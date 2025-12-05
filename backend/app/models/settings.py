from beanie import Document, PydanticObjectId
from pydantic import Field
from typing import Any, Optional, List
from datetime import datetime
from enum import Enum


class SignupMode(str, Enum):
    OPEN = "open"  # Anyone can sign up
    INSTITUTIONAL = "institutional"  # Only emails matching pattern can sign up
    CLOSED = "closed"  # Only admin can create accounts


class AppSettings(Document):
    """Application-wide settings"""
    # Setup status
    is_setup_complete: bool = False
    setup_at: Optional[datetime] = None
    
    # SMTP configuration
    smtp_host: Optional[str] = None
    smtp_port: int = 587
    smtp_user: Optional[str] = None
    smtp_password: Optional[str] = None
    smtp_from_email: Optional[str] = None
    smtp_use_tls: bool = True
    
    # Signup configuration
    signup_mode: SignupMode = SignupMode.CLOSED
    allowed_email_domains: List[str] = Field(default_factory=list)
    
    # Email verification
    require_email_verification: bool = False
    
    # App customization
    app_name: str = "EMTools"
    app_description: str = "Emergency Medicine Tools"
    
    # Feature toggles
    enable_pastebin: bool = True
    enable_public_access: bool = True
    
    # Security
    session_timeout_minutes: int = 30
    max_login_attempts: int = 5
    lockout_duration_minutes: int = 15
    
    created_at: datetime = Field(default_factory=datetime.utcnow)
    updated_at: datetime = Field(default_factory=datetime.utcnow)
    
    class Settings:
        name = "app_settings"


class ActivityLog(Document):
    """Activity/audit log for admin monitoring"""
    user_id: Optional[PydanticObjectId] = None
    action: str  # e.g., "login", "register", "update_settings", etc.
    resource_type: Optional[str] = None  # e.g., "user", "paste", "settings"
    resource_id: Optional[PydanticObjectId] = None
    details: Optional[dict[str, Any]] = None
    ip_address: Optional[str] = None
    user_agent: Optional[str] = None
    created_at: datetime = Field(default_factory=datetime.utcnow)
    
    class Settings:
        name = "activity_logs"


class EmailVerificationToken(Document):
    """Token for email verification"""
    user_id: PydanticObjectId
    token: str
    expires_at: datetime
    used: bool = False
    created_at: datetime = Field(default_factory=datetime.utcnow)
    
    class Settings:
        name = "email_verification_tokens"
