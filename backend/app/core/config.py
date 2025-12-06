from pydantic_settings import BaseSettings
from typing import List
import os
import secrets


class Settings(BaseSettings):
    PROJECT_NAME: str = "EMTOOLS"
    VERSION: str = "2.0.0-beta.4"
    API_V1_STR: str = "/api/v1"
    
    # Environment
    ENVIRONMENT: str = os.getenv("ENVIRONMENT", "development")
    DEBUG: bool = os.getenv("DEBUG", "true").lower() == "true"
    
    # MongoDB
    MONGODB_URL: str = os.getenv("MONGODB_URL", "mongodb://localhost:27017")
    MONGODB_DB_NAME: str = os.getenv("MONGODB_DB_NAME", "emtools")
    
    # JWT - CRITICAL: Must be set in production!
    SECRET_KEY: str = os.getenv("SECRET_KEY", secrets.token_urlsafe(32))
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", "30"))
    REFRESH_TOKEN_EXPIRE_DAYS: int = int(os.getenv("REFRESH_TOKEN_EXPIRE_DAYS", "7"))
    
    # CORS - Configure for production!
    BACKEND_CORS_ORIGINS: List[str] = os.getenv(
        "BACKEND_CORS_ORIGINS", 
        "http://localhost:5173,http://localhost:3000,http://localhost:8080"
    ).split(",")
    
    # Admin - CRITICAL: Change in production!
    FIRST_SUPERUSER_EMAIL: str = os.getenv("FIRST_SUPERUSER_EMAIL", "admin@emtools.com")
    FIRST_SUPERUSER_PASSWORD: str = os.getenv("FIRST_SUPERUSER_PASSWORD", "admin123")
    
    # Security
    MAX_LOGIN_ATTEMPTS: int = int(os.getenv("MAX_LOGIN_ATTEMPTS", "5"))
    LOGIN_LOCKOUT_MINUTES: int = int(os.getenv("LOGIN_LOCKOUT_MINUTES", "15"))
    
    # Paste limits
    MAX_PASTE_SIZE_KB: int = int(os.getenv("MAX_PASTE_SIZE_KB", "500"))
    MAX_PASTE_EXPIRY_HOURS: int = int(os.getenv("MAX_PASTE_EXPIRY_HOURS", "24"))
    
    class Config:
        case_sensitive = True
        env_file = ".env"
    
    def is_production(self) -> bool:
        return self.ENVIRONMENT.lower() == "production"


settings = Settings()

# Security warnings for development
if not settings.is_production():
    import warnings
    if settings.SECRET_KEY == "your-secret-key-change-in-production":
        warnings.warn("⚠️ Using default SECRET_KEY! Set SECRET_KEY env variable in production!")
    if settings.FIRST_SUPERUSER_PASSWORD == "admin123":
        warnings.warn("⚠️ Using default admin password! Change FIRST_SUPERUSER_PASSWORD in production!")
