from pydantic import BaseModel, Field, field_validator
from typing import Optional
from datetime import datetime
import re


class PasteCreate(BaseModel):
    content: str = Field(..., min_length=1, max_length=500000, description="Paste content (max 500KB)")
    title: Optional[str] = Field(None, max_length=200, description="Optional title")
    language: str = Field("text", max_length=50, description="Syntax highlighting language")
    password: Optional[str] = Field(None, min_length=4, max_length=128, description="Optional password")
    expires_in_hours: int = Field(24, ge=1, le=24, description="Expiry in hours (max 24)")
    burn_after_read: bool = False
    max_views: Optional[int] = Field(None, ge=1, le=1000, description="Max view count")
    images: list[str] = Field(default=[], max_length=5, description="Max 5 base64 images")
    
    @field_validator('content')
    @classmethod
    def validate_content(cls, v: str) -> str:
        # Basic XSS prevention - will be escaped on output anyway
        if '<script' in v.lower():
            raise ValueError('Script tags not allowed in content')
        return v
    
    @field_validator('images')
    @classmethod
    def validate_images(cls, v: list) -> list:
        if len(v) > 5:
            raise ValueError('Maximum 5 images allowed')
        for img in v:
            # Validate base64 image format
            if img and not (img.startswith('data:image/') or img.startswith('http')):
                raise ValueError('Invalid image format')
            # Limit image size (roughly 2MB base64)
            if len(img) > 2_800_000:
                raise ValueError('Image too large (max 2MB)')
        return v[:5]


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
