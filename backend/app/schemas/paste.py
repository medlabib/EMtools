from pydantic import BaseModel
from typing import Optional
from datetime import datetime


class PasteCreate(BaseModel):
    content: str
    title: Optional[str] = None
    language: str = "text"
    password: Optional[str] = None
    expires_in_hours: int = 24  # Max 24 hours
    burn_after_read: bool = False
    max_views: Optional[int] = None
    images: list[str] = []  # Base64 encoded images


class PasteResponse(BaseModel):
    paste_id: str
    title: Optional[str]
    content: str
    language: str
    is_protected: bool
    expires_at: datetime
    burn_after_read: bool
    views: int
    max_views: Optional[int]
    images: list[str]
    ocr_text: Optional[str]
    created_at: datetime
    
    class Config:
        from_attributes = True


class PastePublicResponse(BaseModel):
    paste_id: str
    title: Optional[str]
    language: str
    is_protected: bool
    expires_at: datetime
    created_at: datetime


class PasteAccess(BaseModel):
    password: Optional[str] = None


class OCRRequest(BaseModel):
    image: str  # Base64 encoded image
