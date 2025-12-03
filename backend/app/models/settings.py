from beanie import Document
from pydantic import Field, EmailStr
from typing import Optional, List
from datetime import datetime
from enum import Enum


class SignupMode(str, Enum):
    OPEN = "open"  # Anyone can sign up
    INSTITUTIONAL = "institutional"  # Only emails matching pattern can sign up
    CLOSED = "closed"  # Only admin can create accounts


class SMTPConfig(Document):
    """SMTP configuration for email sending"""
    host: str = ""
    port: int = 587
    username: str = ""
    password: str = ""  # Should be encrypted in production
    from_email: str = ""
    from_name: str = "EMTools"
    use_tls: bool = True
    is_configured: bool = False
    
    class Settings:
        name = "smtp_config"


class AppSettings(Document):
    """Application-wide settings"""
    # Setup status
    is_setup_complete: bool = False
    setup_completed_at: Optional[datetime] = None
    
    # Signup configuration
    signup_mode: SignupMode = SignupMode.OPEN
    allowed_email_domains: List[str] = []  # e.g., ["utm.tn", "hospital.org"]
    
    # Email verification
    require_email_verification: bool = False
    
    # App customization
    app_name: str = "EMTools"
    app_description: str = "Emergency Medicine Tools"
    
    # Feature toggles
    enable_pastebin: bool = True
    enable_public_access: bool = True  # Allow access to some tools without login
    
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
    user_id: Optional[str] = None
    user_email: Optional[str] = None
    action: str  # e.g., "login", "register", "update_settings", etc.
    resource_type: Optional[str] = None  # e.g., "user", "paste", "settings"
    resource_id: Optional[str] = None
    details: Optional[dict] = None
    ip_address: Optional[str] = None
    user_agent: Optional[str] = None
    timestamp: datetime = Field(default_factory=datetime.utcnow)
    
    class Settings:
        name = "activity_logs"


class EmailVerificationToken(Document):
    """Token for email verification"""
    user_id: str
    token: str
    expires_at: datetime
    used: bool = False
    created_at: datetime = Field(default_factory=datetime.utcnow)
    
    class Settings:
        name = "email_verification_tokens"
