from fastapi import APIRouter, Depends, HTTPException, status, Query, Request
from typing import List, Optional
from datetime import datetime, timedelta

from beanie import PydanticObjectId
from app.schemas.user import UserResponse, UserUpdate
from app.schemas.admin import (
    SetupRequest,
    SetupStatusResponse,
    SmtpSettings,
    AppSettingsResponse,
    AppSettingsUpdate,
    ActivityLogResponse,
    AdminCreateUser,
    AdminUpdateUser,
    DashboardStats,
    SignupMode,
)
from app.models.user import User, UserRole
from app.models.settings import AppSettings, ActivityLog, SignupMode as SettingsSignupMode
from app.api.deps import get_current_admin_user
from app.core.security import get_password_hash

router = APIRouter()


@router.get("/users", response_model=List[UserResponse])
async def list_users(
    skip: int = Query(0, ge=0),
    limit: int = Query(10, ge=1, le=100),
    role: Optional[UserRole] = None,
    is_active: Optional[bool] = None,
    current_user: User = Depends(get_current_admin_user)
):
    """List all users (Admin only)"""
    query = {}
    
    if role:
        query["role"] = role
    if is_active is not None:
        query["is_active"] = is_active
    
    users = await User.find(query).skip(skip).limit(limit).to_list()
    
    return [
        UserResponse(
            id=str(user.id),
            email=user.email,
            username=user.username,
            full_name=user.full_name,
            is_active=user.is_active,
            is_verified=user.is_verified,
            is_superuser=user.is_superuser,
            role=user.role,
            created_at=user.created_at
        )
        for user in users
    ]


@router.get("/users/count")
async def count_users(
    role: Optional[UserRole] = None,
    is_active: Optional[bool] = None,
    current_user: User = Depends(get_current_admin_user)
):
    """Get total user count (Admin only)"""
    query = {}
    
    if role:
        query["role"] = role
    if is_active is not None:
        query["is_active"] = is_active
    
    count = await User.find(query).count()
    return {"count": count}


@router.get("/users/{user_id}", response_model=UserResponse)
async def get_user(
    user_id: str,
    current_user: User = Depends(get_current_admin_user)
):
    """Get user by ID (Admin only)"""
    user = await User.get(user_id)
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    
    return UserResponse(
        id=str(user.id),
        email=user.email,
        username=user.username,
        full_name=user.full_name,
        is_active=user.is_active,
        is_verified=user.is_verified,
        is_superuser=user.is_superuser,
        role=user.role,
        created_at=user.created_at
    )


@router.put("/users/{user_id}", response_model=UserResponse)
async def update_user(
    user_id: str,
    user_update: UserUpdate,
    current_user: User = Depends(get_current_admin_user)
):
    """Update user (Admin only)"""
    user = await User.get(user_id)
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    
    update_data = user_update.model_dump(exclude_unset=True)
    
    if "password" in update_data:
        update_data["hashed_password"] = get_password_hash(update_data.pop("password"))
    
    update_data["updated_at"] = datetime.utcnow()
    
    for field, value in update_data.items():
        setattr(user, field, value)
    
    await user.save()
    
    return UserResponse(
        id=str(user.id),
        email=user.email,
        username=user.username,
        full_name=user.full_name,
        is_active=user.is_active,
        is_verified=user.is_verified,
        is_superuser=user.is_superuser,
        role=user.role,
        created_at=user.created_at
    )


@router.delete("/users/{user_id}")
async def delete_user(
    user_id: str,
    current_user: User = Depends(get_current_admin_user)
):
    """Delete user (Admin only)"""
    user = await User.get(user_id)
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    
    if str(user.id) == str(current_user.id):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Cannot delete yourself"
        )
    
    await user.delete()
    
    return {"message": "User deleted successfully"}


@router.get("/dashboard/stats")
async def get_dashboard_stats(current_user: User = Depends(get_current_admin_user)):
    """Get dashboard statistics (Admin only)"""
    total_users = await User.find().count()
    active_users = await User.find(User.is_active == True).count()
    admin_users = await User.find(User.role == UserRole.ADMIN).count()
    
    return {
        "total_users": total_users,
        "active_users": active_users,
        "inactive_users": total_users - active_users,
        "admin_users": admin_users,
        "regular_users": total_users - admin_users
    }


# ============================================================================
# SETUP ENDPOINTS (No auth required for initial setup)
# ============================================================================


@router.get("/setup/status", response_model=SetupStatusResponse)
async def get_setup_status():
    """Check if the application has been set up."""
    settings = await AppSettings.find_one()
    
    if settings is None:
        return SetupStatusResponse(
            is_setup_complete=False,
            has_admin=False,
            message="Application requires initial setup"
        )
    
    admin_count = await User.find(User.role == UserRole.ADMIN).count()
    
    return SetupStatusResponse(
        is_setup_complete=settings.is_setup_complete,
        has_admin=admin_count > 0,
        message="Application is configured" if settings.is_setup_complete else "Setup incomplete"
    )


@router.post("/setup", response_model=SetupStatusResponse)
async def initial_setup(setup_data: SetupRequest, request: Request):
    """
    Perform initial application setup.
    Creates the first admin user and configures basic settings.
    This endpoint only works if setup hasn't been completed yet.
    """
    # Check if setup already completed
    existing_settings = await AppSettings.find_one()
    if existing_settings and existing_settings.is_setup_complete:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Setup has already been completed"
        )
    
    # Check if admin already exists
    existing_admin = await User.find_one(User.role == UserRole.ADMIN)
    if existing_admin:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="An admin user already exists"
        )
    
    # Validate email uniqueness
    existing_user = await User.find_one(User.email == setup_data.admin_email)
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )
    
    # Create admin user
    admin_user = User(
        email=setup_data.admin_email,
        username=setup_data.admin_username,
        hashed_password=get_password_hash(setup_data.admin_password),
        role=UserRole.ADMIN,
        is_verified=True,
        is_active=True,
    )
    await admin_user.insert()
    
    # Create or update settings
    settings_data = {
        "signup_mode": SettingsSignupMode(setup_data.signup_mode.value) if setup_data.signup_mode else SettingsSignupMode.CLOSED,
        "is_setup_complete": True,
        "setup_at": datetime.utcnow(),
    }
    
    if setup_data.smtp_settings:
        settings_data.update({
            "smtp_host": setup_data.smtp_settings.smtp_host,
            "smtp_port": setup_data.smtp_settings.smtp_port,
            "smtp_user": setup_data.smtp_settings.smtp_user,
            "smtp_password": setup_data.smtp_settings.smtp_password,
            "smtp_from_email": setup_data.smtp_settings.smtp_from_email,
            "smtp_use_tls": setup_data.smtp_settings.smtp_use_tls,
        })
    
    if setup_data.allowed_email_domains:
        settings_data["allowed_email_domains"] = setup_data.allowed_email_domains
    
    if existing_settings:
        for key, value in settings_data.items():
            setattr(existing_settings, key, value)
        await existing_settings.save()
    else:
        app_settings = AppSettings(**settings_data)
        await app_settings.insert()
    
    # Log the setup activity
    await ActivityLog(
        user_id=admin_user.id,
        action="initial_setup",
        resource_type="system",
        details={"signup_mode": setup_data.signup_mode.value if setup_data.signup_mode else "closed"},
        ip_address=request.client.host if request.client else None,
        user_agent=request.headers.get("user-agent"),
    ).insert()
    
    return SetupStatusResponse(
        is_setup_complete=True,
        has_admin=True,
        message="Setup completed successfully"
    )


# ============================================================================
# SETTINGS ENDPOINTS (Admin only)
# ============================================================================


@router.get("/settings", response_model=AppSettingsResponse)
async def get_settings(current_user: User = Depends(get_current_admin_user)):
    """Get application settings."""
    settings = await AppSettings.find_one()
    
    if settings is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Settings not found. Please complete setup first."
        )
    
    return AppSettingsResponse(
        signup_mode=SignupMode(settings.signup_mode.value),
        allowed_email_domains=settings.allowed_email_domains,
        smtp_configured=bool(settings.smtp_host and settings.smtp_user),
        smtp_host=settings.smtp_host,
        smtp_port=settings.smtp_port,
        smtp_from_email=settings.smtp_from_email,
        smtp_use_tls=settings.smtp_use_tls,
        is_setup_complete=settings.is_setup_complete,
        setup_at=settings.setup_at,
    )


@router.patch("/settings", response_model=AppSettingsResponse)
async def update_settings(
    update_data: AppSettingsUpdate,
    request: Request,
    current_user: User = Depends(get_current_admin_user),
):
    """Update application settings."""
    settings = await AppSettings.find_one()
    
    if settings is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Settings not found. Please complete setup first."
        )
    
    update_dict = update_data.model_dump(exclude_unset=True)
    changes = {}
    
    for field, value in update_dict.items():
        if field == "signup_mode" and value:
            value = SettingsSignupMode(value.value)
        if hasattr(settings, field) and getattr(settings, field) != value:
            changes[field] = {"old": str(getattr(settings, field)), "new": str(value)}
            setattr(settings, field, value)
    
    settings.updated_at = datetime.utcnow()
    await settings.save()
    
    # Log the activity
    if changes:
        await ActivityLog(
            user_id=current_user.id,
            action="update_settings",
            resource_type="settings",
            details={"changes": changes},
            ip_address=request.client.host if request.client else None,
            user_agent=request.headers.get("user-agent"),
        ).insert()
    
    return AppSettingsResponse(
        signup_mode=SignupMode(settings.signup_mode.value),
        allowed_email_domains=settings.allowed_email_domains,
        smtp_configured=bool(settings.smtp_host and settings.smtp_user),
        smtp_host=settings.smtp_host,
        smtp_port=settings.smtp_port,
        smtp_from_email=settings.smtp_from_email,
        smtp_use_tls=settings.smtp_use_tls,
        is_setup_complete=settings.is_setup_complete,
        setup_at=settings.setup_at,
    )


@router.put("/settings/smtp", response_model=AppSettingsResponse)
async def update_smtp_settings(
    smtp_settings: SmtpSettings,
    request: Request,
    current_user: User = Depends(get_current_admin_user),
):
    """Update SMTP settings for email functionality."""
    settings = await AppSettings.find_one()
    
    if settings is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Settings not found. Please complete setup first."
        )
    
    settings.smtp_host = smtp_settings.smtp_host
    settings.smtp_port = smtp_settings.smtp_port
    settings.smtp_user = smtp_settings.smtp_user
    settings.smtp_password = smtp_settings.smtp_password
    settings.smtp_from_email = smtp_settings.smtp_from_email
    settings.smtp_use_tls = smtp_settings.smtp_use_tls
    settings.updated_at = datetime.utcnow()
    await settings.save()
    
    # Log the activity
    await ActivityLog(
        user_id=current_user.id,
        action="update_smtp",
        resource_type="settings",
        details={"smtp_host": smtp_settings.smtp_host},
        ip_address=request.client.host if request.client else None,
        user_agent=request.headers.get("user-agent"),
    ).insert()
    
    return AppSettingsResponse(
        signup_mode=SignupMode(settings.signup_mode.value),
        allowed_email_domains=settings.allowed_email_domains,
        smtp_configured=True,
        smtp_host=settings.smtp_host,
        smtp_port=settings.smtp_port,
        smtp_from_email=settings.smtp_from_email,
        smtp_use_tls=settings.smtp_use_tls,
        is_setup_complete=settings.is_setup_complete,
        setup_at=settings.setup_at,
    )


@router.post("/settings/smtp/test")
async def test_smtp_settings(
    current_user: User = Depends(get_current_admin_user),
):
    """Test SMTP settings by sending a test email."""
    settings = await AppSettings.find_one()
    
    if settings is None or not settings.smtp_host:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="SMTP not configured"
        )
    
    # TODO: Implement actual email sending test
    return {"status": "ok", "message": "SMTP settings appear valid (test email not implemented yet)"}


# ============================================================================
# ACTIVITY LOGS ENDPOINTS (Admin only)
# ============================================================================


@router.get("/logs", response_model=List[ActivityLogResponse])
async def get_activity_logs(
    skip: int = Query(0, ge=0),
    limit: int = Query(50, ge=1, le=100),
    user_id: Optional[str] = None,
    action: Optional[str] = None,
    resource_type: Optional[str] = None,
    current_user: User = Depends(get_current_admin_user),
):
    """Get activity logs with optional filtering."""
    query = {}
    
    if user_id:
        query["user_id"] = PydanticObjectId(user_id)
    if action:
        query["action"] = action
    if resource_type:
        query["resource_type"] = resource_type
    
    logs = await ActivityLog.find(query).sort(-ActivityLog.created_at).skip(skip).limit(limit).to_list()
    
    # Get unique user IDs and fetch their emails
    user_ids = {log.user_id for log in logs if log.user_id}
    user_emails = {}
    if user_ids:
        users = await User.find({"_id": {"$in": list(user_ids)}}).to_list()
        user_emails = {user.id: user.email for user in users}
    
    return [
        ActivityLogResponse(
            id=str(log.id),
            user_id=str(log.user_id) if log.user_id else None,
            user_email=user_emails.get(log.user_id) if log.user_id else None,
            action=log.action,
            resource_type=log.resource_type,
            resource_id=str(log.resource_id) if log.resource_id else None,
            details=log.details,
            ip_address=log.ip_address,
            user_agent=log.user_agent,
            created_at=log.created_at,
        )
        for log in logs
    ]


@router.get("/logs/count")
async def get_activity_logs_count(
    user_id: Optional[str] = None,
    action: Optional[str] = None,
    resource_type: Optional[str] = None,
    current_user: User = Depends(get_current_admin_user),
):
    """Get total count of activity logs with optional filtering."""
    query = {}
    
    if user_id:
        query["user_id"] = PydanticObjectId(user_id)
    if action:
        query["action"] = action
    if resource_type:
        query["resource_type"] = resource_type
    
    count = await ActivityLog.find(query).count()
    return {"count": count}


# ============================================================================
# DASHBOARD STATS V2 (with more details)
# ============================================================================


@router.get("/dashboard/stats/v2", response_model=DashboardStats)
async def get_dashboard_stats_v2(
    current_user: User = Depends(get_current_admin_user),
):
    """Get enhanced dashboard statistics."""
    total_users = await User.find().count()
    active_users = await User.find(User.is_active == True).count()
    admin_users = await User.find(User.role == UserRole.ADMIN).count()
    verified_users = await User.find(User.is_verified == True).count()
    
    # Get recent activity count (last 24 hours)
    yesterday = datetime.utcnow() - timedelta(days=1)
    recent_activities = await ActivityLog.find(ActivityLog.created_at >= yesterday).count()
    
    # Get settings
    settings = await AppSettings.find_one()
    
    return DashboardStats(
        total_users=total_users,
        active_users=active_users,
        admin_users=admin_users,
        verified_users=verified_users,
        recent_activities=recent_activities,
        signup_mode=SignupMode(settings.signup_mode.value) if settings else SignupMode.CLOSED,
        smtp_configured=bool(settings and settings.smtp_host and settings.smtp_user) if settings else False,
    )
