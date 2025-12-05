"""Admin schemas for setup, settings, and activity logs."""
from datetime import datetime
from enum import Enum
from typing import Any, Optional

from pydantic import BaseModel, EmailStr, Field


class SignupMode(str, Enum):
    """Signup mode options for the application."""
    OPEN = "open"  # Anyone can sign up
    INSTITUTIONAL = "institutional"  # Only allowed email domains can sign up
    CLOSED = "closed"  # No public signup, admin creates accounts


# ============================================================================
# SETUP SCHEMAS
# ============================================================================


class SmtpSettings(BaseModel):
    """SMTP configuration for email functionality."""
    smtp_host: str = Field(..., min_length=1, description="SMTP server hostname")
    smtp_port: int = Field(587, ge=1, le=65535, description="SMTP server port")
    smtp_user: str = Field(..., min_length=1, description="SMTP username")
    smtp_password: str = Field(..., min_length=1, description="SMTP password")
    smtp_from_email: EmailStr = Field(..., description="From email address")
    smtp_use_tls: bool = Field(True, description="Use TLS encryption")


class SetupRequest(BaseModel):
    """Initial setup request to create admin and configure app."""
    admin_email: EmailStr = Field(..., description="Admin email address")
    admin_username: str = Field(..., min_length=3, max_length=50, description="Admin username")
    admin_password: str = Field(..., min_length=8, description="Admin password")
    signup_mode: Optional[SignupMode] = Field(SignupMode.CLOSED, description="Signup mode")
    smtp_settings: Optional[SmtpSettings] = Field(None, description="Optional SMTP configuration")
    allowed_email_domains: Optional[list[str]] = Field(None, description="Allowed email domains for institutional signup")


class SetupStatusResponse(BaseModel):
    """Response for setup status check."""
    is_setup_complete: bool
    has_admin: bool
    message: str


# ============================================================================
# SETTINGS SCHEMAS
# ============================================================================


class AppSettingsUpdate(BaseModel):
    """Update request for application settings."""
    signup_mode: Optional[SignupMode] = None
    allowed_email_domains: Optional[list[str]] = None
    smtp_host: Optional[str] = None
    smtp_port: Optional[int] = Field(None, ge=1, le=65535)
    smtp_user: Optional[str] = None
    smtp_password: Optional[str] = None
    smtp_from_email: Optional[EmailStr] = None
    smtp_use_tls: Optional[bool] = None


class AppSettingsResponse(BaseModel):
    """Response containing application settings."""
    signup_mode: SignupMode
    allowed_email_domains: list[str]
    smtp_configured: bool
    smtp_host: Optional[str] = None
    smtp_port: Optional[int] = None
    smtp_from_email: Optional[str] = None
    smtp_use_tls: Optional[bool] = None
    is_setup_complete: bool
    setup_at: Optional[datetime] = None


# ============================================================================
# ACTIVITY LOG SCHEMAS
# ============================================================================


class ActivityLogResponse(BaseModel):
    """Response containing activity log entry."""
    id: str
    user_id: Optional[str] = None
    user_email: Optional[str] = None
    action: str
    resource_type: Optional[str] = None
    resource_id: Optional[str] = None
    details: Optional[dict[str, Any]] = None
    ip_address: Optional[str] = None
    user_agent: Optional[str] = None
    created_at: datetime


# ============================================================================
# USER MANAGEMENT SCHEMAS
# ============================================================================


class AdminCreateUser(BaseModel):
    """Admin request to create a new user."""
    email: EmailStr
    username: str = Field(..., min_length=3, max_length=50)
    password: str = Field(..., min_length=8)
    role: Optional[str] = "user"
    is_verified: Optional[bool] = True
    is_active: Optional[bool] = True


class AdminUpdateUser(BaseModel):
    """Admin request to update a user."""
    email: Optional[EmailStr] = None
    username: Optional[str] = Field(None, min_length=3, max_length=50)
    password: Optional[str] = Field(None, min_length=8)
    role: Optional[str] = None
    is_verified: Optional[bool] = None
    is_active: Optional[bool] = None


# ============================================================================
# DASHBOARD SCHEMAS
# ============================================================================


class DashboardStats(BaseModel):
    """Dashboard statistics response."""
    total_users: int
    active_users: int
    admin_users: int
    verified_users: int
    recent_activities: int
    signup_mode: SignupMode
    smtp_configured: bool
