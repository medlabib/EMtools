"""
Pytest configuration and fixtures for EMTOOLS backend tests
"""
import pytest
import asyncio
from typing import AsyncGenerator, Generator
from httpx import AsyncClient, ASGITransport
from unittest.mock import AsyncMock, MagicMock, patch
from datetime import datetime, timedelta
import os

# Set test environment before importing app
os.environ["MONGODB_URL"] = "mongodb://localhost:27017"
os.environ["MONGODB_DB_NAME"] = "emtools_test"
os.environ["SECRET_KEY"] = "test-secret-key-for-testing"

from app.main import app
from app.models.user import User
from app.models.paste import Paste
from app.core.security import create_access_token, get_password_hash


@pytest.fixture(scope="session")
def event_loop() -> Generator:
    """Create event loop for async tests"""
    loop = asyncio.get_event_loop_policy().new_event_loop()
    yield loop
    loop.close()


@pytest.fixture
def mock_user() -> dict:
    """Create a mock user data"""
    return {
        "id": "507f1f77bcf86cd799439011",
        "email": "test@example.com",
        "full_name": "Test User",
        "hashed_password": get_password_hash("testpassword123"),
        "is_active": True,
        "is_superuser": False,
        "role": "user",
        "created_at": datetime.utcnow()
    }


@pytest.fixture
def mock_admin_user() -> dict:
    """Create a mock admin user data"""
    return {
        "id": "507f1f77bcf86cd799439012",
        "email": "admin@example.com",
        "full_name": "Admin User",
        "hashed_password": get_password_hash("adminpassword123"),
        "is_active": True,
        "is_superuser": True,
        "role": "admin",
        "created_at": datetime.utcnow()
    }


@pytest.fixture
def auth_token(mock_user: dict) -> str:
    """Generate access token for testing"""
    return create_access_token(data={"sub": mock_user["id"]})


@pytest.fixture
def admin_auth_token(mock_admin_user: dict) -> str:
    """Generate admin access token for testing"""
    return create_access_token(data={"sub": mock_admin_user["id"]})


@pytest.fixture
def mock_paste() -> dict:
    """Create a mock paste data"""
    return {
        "paste_id": "abc123xyz",
        "content": "Test paste content",
        "title": "Test Paste",
        "language": "text",
        "is_protected": False,
        "password_hash": None,
        "expires_at": datetime.utcnow() + timedelta(hours=24),
        "created_at": datetime.utcnow(),
        "burn_after_read": False,
        "views": 0,
        "max_views": None,
        "images": []
    }


@pytest.fixture
async def async_client() -> AsyncGenerator[AsyncClient, None]:
    """Create async HTTP client for testing"""
    # Mock MongoDB connection
    with patch("app.db.mongodb.connect_to_mongo", new_callable=AsyncMock):
        with patch("app.db.mongodb.close_mongo_connection", new_callable=AsyncMock):
            transport = ASGITransport(app=app)
            async with AsyncClient(transport=transport, base_url="http://test") as client:
                yield client
