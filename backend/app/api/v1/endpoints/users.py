from fastapi import APIRouter, Depends, HTTPException, status
from typing import List

from app.schemas.user import UserResponse, UserUpdate
from app.models.user import User
from app.api.deps import get_current_user, get_current_active_user

router = APIRouter()


@router.get("/me", response_model=UserResponse)
async def get_current_user_info(current_user: User = Depends(get_current_active_user)):
    """Get current user information"""
    return UserResponse(
        id=str(current_user.id),
        email=current_user.email,
        username=current_user.username,
        full_name=current_user.full_name,
        is_active=current_user.is_active,
        is_verified=current_user.is_verified,
        is_superuser=current_user.is_superuser,
        role=current_user.role,
        created_at=current_user.created_at
    )


@router.put("/me", response_model=UserResponse)
async def update_current_user(
    user_update: UserUpdate,
    current_user: User = Depends(get_current_active_user)
):
    """Update current user information"""
    from app.core.security import get_password_hash
    from datetime import datetime
    
    update_data = user_update.model_dump(exclude_unset=True)
    
    if "password" in update_data:
        update_data["hashed_password"] = get_password_hash(update_data.pop("password"))
    
    # Users cannot change their own role or verification status
    if "role" in update_data:
        del update_data["role"]
    if "is_verified" in update_data:
        del update_data["is_verified"]
    
    # Check username uniqueness
    if "username" in update_data and update_data["username"] != current_user.username:
        existing_user = await User.find_one(User.username == update_data["username"])
        if existing_user:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Username already taken"
            )
    
    update_data["updated_at"] = datetime.utcnow()
    
    for field, value in update_data.items():
        setattr(current_user, field, value)
    
    await current_user.save()
    
    return UserResponse(
        id=str(current_user.id),
        email=current_user.email,
        username=current_user.username,
        full_name=current_user.full_name,
        is_active=current_user.is_active,
        is_verified=current_user.is_verified,
        is_superuser=current_user.is_superuser,
        role=current_user.role,
        created_at=current_user.created_at
    )
