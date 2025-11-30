from fastapi import APIRouter
from app.api.v1.endpoints import auth, users, admin, paste

api_router = APIRouter()

api_router.include_router(auth.router, prefix="/auth", tags=["Authentication"])
api_router.include_router(users.router, prefix="/users", tags=["Users"])
api_router.include_router(admin.router, prefix="/admin", tags=["Admin"])
api_router.include_router(paste.router, prefix="/paste", tags=["Pastebin"])
