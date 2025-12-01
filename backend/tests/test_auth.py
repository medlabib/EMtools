"""
Tests for authentication endpoints
"""
import pytest
from unittest.mock import AsyncMock, MagicMock, patch
from datetime import datetime


class TestAuthEndpoints:
    """Test suite for /api/v1/auth endpoints"""

    @pytest.mark.asyncio
    async def test_root_endpoint(self, async_client):
        """Test root endpoint returns welcome message"""
        response = await async_client.get("/")
        assert response.status_code == 200
        data = response.json()
        assert "message" in data
        assert "EMTOOLS" in data["message"]

    @pytest.mark.asyncio
    async def test_health_endpoint(self, async_client):
        """Test health check endpoint"""
        response = await async_client.get("/health")
        assert response.status_code == 200
        data = response.json()
        assert data["status"] == "healthy"

    @pytest.mark.asyncio
    async def test_register_success(self, async_client):
        """Test successful user registration"""
        mock_user = MagicMock()
        mock_user.id = "507f1f77bcf86cd799439011"
        mock_user.email = "newuser@example.com"
        mock_user.full_name = "New User"
        mock_user.is_active = True
        mock_user.is_superuser = False
        mock_user.role = "user"
        mock_user.created_at = datetime.utcnow()
        mock_user.insert = AsyncMock()

        with patch("app.api.v1.endpoints.auth.User") as MockUser:
            MockUser.find_one = AsyncMock(return_value=None)
            MockUser.return_value = mock_user

            response = await async_client.post(
                "/api/v1/auth/register",
                json={
                    "email": "newuser@example.com",
                    "password": "securepassword123",
                    "full_name": "New User"
                }
            )
            
            assert response.status_code == 201
            data = response.json()
            assert data["email"] == "newuser@example.com"
            assert data["full_name"] == "New User"
            assert "id" in data

    @pytest.mark.asyncio
    async def test_register_duplicate_email(self, async_client, mock_user):
        """Test registration with existing email fails"""
        existing_user = MagicMock()
        existing_user.email = mock_user["email"]

        with patch("app.api.v1.endpoints.auth.User") as MockUser:
            MockUser.find_one = AsyncMock(return_value=existing_user)

            response = await async_client.post(
                "/api/v1/auth/register",
                json={
                    "email": mock_user["email"],
                    "password": "password123",
                    "full_name": "Test User"
                }
            )
            
            assert response.status_code == 400
            assert "already registered" in response.json()["detail"]

    @pytest.mark.asyncio
    async def test_login_success(self, async_client, mock_user):
        """Test successful login"""
        user_obj = MagicMock()
        user_obj.id = mock_user["id"]
        user_obj.email = mock_user["email"]
        user_obj.hashed_password = mock_user["hashed_password"]
        user_obj.is_active = True

        with patch("app.api.v1.endpoints.auth.User") as MockUser:
            MockUser.find_one = AsyncMock(return_value=user_obj)

            response = await async_client.post(
                "/api/v1/auth/login",
                data={
                    "username": mock_user["email"],
                    "password": "testpassword123"
                }
            )
            
            assert response.status_code == 200
            data = response.json()
            assert "access_token" in data
            assert "refresh_token" in data
            assert data["token_type"] == "bearer"

    @pytest.mark.asyncio
    async def test_login_wrong_password(self, async_client, mock_user):
        """Test login with wrong password"""
        user_obj = MagicMock()
        user_obj.id = mock_user["id"]
        user_obj.email = mock_user["email"]
        user_obj.hashed_password = mock_user["hashed_password"]
        user_obj.is_active = True

        with patch("app.api.v1.endpoints.auth.User") as MockUser:
            MockUser.find_one = AsyncMock(return_value=user_obj)

            response = await async_client.post(
                "/api/v1/auth/login",
                data={
                    "username": mock_user["email"],
                    "password": "wrongpassword"
                }
            )
            
            assert response.status_code == 401

    @pytest.mark.asyncio
    async def test_login_nonexistent_user(self, async_client):
        """Test login with non-existent user"""
        with patch("app.api.v1.endpoints.auth.User") as MockUser:
            MockUser.find_one = AsyncMock(return_value=None)

            response = await async_client.post(
                "/api/v1/auth/login",
                data={
                    "username": "nonexistent@example.com",
                    "password": "password123"
                }
            )
            
            assert response.status_code == 401

    @pytest.mark.asyncio
    async def test_login_inactive_user(self, async_client, mock_user):
        """Test login with inactive user"""
        user_obj = MagicMock()
        user_obj.id = mock_user["id"]
        user_obj.email = mock_user["email"]
        user_obj.hashed_password = mock_user["hashed_password"]
        user_obj.is_active = False  # Inactive user

        with patch("app.api.v1.endpoints.auth.User") as MockUser:
            MockUser.find_one = AsyncMock(return_value=user_obj)

            response = await async_client.post(
                "/api/v1/auth/login",
                data={
                    "username": mock_user["email"],
                    "password": "testpassword123"
                }
            )
            
            assert response.status_code == 403
            assert "disabled" in response.json()["detail"]


class TestTokenRefresh:
    """Test suite for token refresh functionality"""

    @pytest.mark.asyncio
    async def test_refresh_token_endpoint_exists(self, async_client):
        """Test that refresh endpoint returns 422 without proper data"""
        response = await async_client.post("/api/v1/auth/refresh")
        # Should fail with 422 (validation error) or 401 (unauthorized)
        assert response.status_code in [401, 422]

    @pytest.mark.asyncio
    async def test_api_docs_available(self, async_client):
        """Test OpenAPI docs are available"""
        response = await async_client.get("/docs")
        assert response.status_code == 200
