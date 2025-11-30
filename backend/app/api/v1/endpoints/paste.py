from fastapi import APIRouter, HTTPException, status
from datetime import datetime, timedelta
from typing import Optional

from app.schemas.paste import PasteCreate, PasteResponse, PastePublicResponse, PasteAccess
from app.models.paste import Paste
from app.core.security import get_password_hash, verify_password

router = APIRouter()

MAX_EXPIRY_HOURS = 24


@router.post("/", response_model=PastePublicResponse, status_code=status.HTTP_201_CREATED)
async def create_paste(paste_data: PasteCreate):
    """Create a new paste"""
    # Validate expiry time (max 24 hours)
    expires_in = min(paste_data.expires_in_hours, MAX_EXPIRY_HOURS)
    expires_at = datetime.utcnow() + timedelta(hours=expires_in)
    
    # Create paste
    paste = Paste(
        content=paste_data.content,
        title=paste_data.title,
        language=paste_data.language,
        is_protected=bool(paste_data.password),
        password_hash=get_password_hash(paste_data.password) if paste_data.password else None,
        expires_at=expires_at,
        burn_after_read=paste_data.burn_after_read,
        max_views=paste_data.max_views,
        images=paste_data.images[:5],  # Limit to 5 images
    )
    
    await paste.insert()
    
    return PastePublicResponse(
        paste_id=paste.paste_id,
        title=paste.title,
        language=paste.language,
        is_protected=paste.is_protected,
        expires_at=paste.expires_at,
        created_at=paste.created_at
    )


@router.get("/{paste_id}", response_model=PastePublicResponse)
async def get_paste_info(paste_id: str):
    """Get paste metadata (without content if protected)"""
    paste = await Paste.find_one(Paste.paste_id == paste_id)
    
    if not paste:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Paste not found"
        )
    
    # Check if expired
    if paste.expires_at < datetime.utcnow():
        await paste.delete()
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Paste has expired"
        )
    
    # Check max views
    if paste.max_views and paste.views >= paste.max_views:
        await paste.delete()
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Paste view limit reached"
        )
    
    return PastePublicResponse(
        paste_id=paste.paste_id,
        title=paste.title,
        language=paste.language,
        is_protected=paste.is_protected,
        expires_at=paste.expires_at,
        created_at=paste.created_at
    )


@router.post("/{paste_id}/access", response_model=PasteResponse)
async def access_paste(paste_id: str, access: PasteAccess):
    """Access paste content (with password if required)"""
    paste = await Paste.find_one(Paste.paste_id == paste_id)
    
    if not paste:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Paste not found"
        )
    
    # Check if expired
    if paste.expires_at < datetime.utcnow():
        await paste.delete()
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Paste has expired"
        )
    
    # Check max views
    if paste.max_views and paste.views >= paste.max_views:
        await paste.delete()
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Paste view limit reached"
        )
    
    # Check password if protected
    if paste.is_protected:
        if not access.password:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Password required"
            )
        if not verify_password(access.password, paste.password_hash):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid password"
            )
    
    # Increment views
    paste.views += 1
    await paste.save()
    
    response = PasteResponse(
        paste_id=paste.paste_id,
        title=paste.title,
        content=paste.content,
        language=paste.language,
        is_protected=paste.is_protected,
        expires_at=paste.expires_at,
        burn_after_read=paste.burn_after_read,
        views=paste.views,
        max_views=paste.max_views,
        images=paste.images,
        ocr_text=paste.ocr_text,
        created_at=paste.created_at
    )
    
    # Delete if burn after read
    if paste.burn_after_read:
        await paste.delete()
    
    return response


@router.delete("/{paste_id}")
async def delete_paste(paste_id: str):
    """Delete a paste"""
    paste = await Paste.find_one(Paste.paste_id == paste_id)
    
    if not paste:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Paste not found"
        )
    
    await paste.delete()
    return {"message": "Paste deleted successfully"}
