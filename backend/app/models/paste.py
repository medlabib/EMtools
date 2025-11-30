from beanie import Document
from pydantic import Field
from typing import Optional
from datetime import datetime
from enum import Enum
import secrets


class Paste(Document):
    paste_id: str = Field(default_factory=lambda: secrets.token_urlsafe(8))
    content: str
    title: Optional[str] = None
    language: str = "text"
    
    # Password protection
    is_protected: bool = False
    password_hash: Optional[str] = None
    
    # Expiration
    expires_at: datetime
    burn_after_read: bool = False
    views: int = 0
    max_views: Optional[int] = None
    
    # Images
    images: list[str] = Field(default_factory=list)  # Base64 or URLs
    
    # OCR extracted text
    ocr_text: Optional[str] = None
    
    # Metadata
    created_at: datetime = Field(default_factory=datetime.utcnow)
    created_by: Optional[str] = None  # User ID if authenticated
    
    class Settings:
        name = "pastes"
        
    class Config:
        json_schema_extra = {
            "example": {
                "content": "Hello World!",
                "title": "My Paste",
                "expires_at": "2024-01-01T00:00:00"
            }
        }
