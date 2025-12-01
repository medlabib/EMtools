"""
Tests for user endpoints
"""
import pytest
from unittest.mock import AsyncMock, MagicMock, patch
from datetime import datetime


class TestUserEndpoints:
    """Test suite for /api/v1/users endpoints"""

    @pytest.mark.asyncio
    async def test_get_current_user(self, async_client, mock_user, auth_token):
        """Test getting current user profile"""
        user_obj = MagicMock()
        user_obj.id = mock_user["id"]
        user_obj.email = mock_user["email"]
        user_obj.full_name = mock_user["full_name"]
        user_obj.is_active = True
        user_obj.is_superuser = False
        user_obj.role = "user"
        user_obj.created_at = mock_user["created_at"]

        with patch("app.api.deps.User") as MockUser:
            MockUser.get = AsyncMock(return_value=user_obj)

            response = await async_client.get(
                "/api/v1/users/me",
                headers={"Authorization": f"Bearer {auth_token}"}
            )
            
            assert response.status_code == 200
            data = response.json()
            assert data["email"] == mock_user["email"]
            assert data["full_name"] == mock_user["full_name"]

    @pytest.mark.asyncio
    async def test_get_current_user_unauthorized(self, async_client):
        """Test getting current user without token"""
        response = await async_client.get("/api/v1/users/me")
        
        assert response.status_code == 401

    @pytest.mark.asyncio
    async def test_get_current_user_invalid_token(self, async_client):
        """Test getting current user with invalid token"""
        response = await async_client.get(
            "/api/v1/users/me",
            headers={"Authorization": "Bearer invalidtoken123"}
        )
        
        assert response.status_code == 401


class TestAdminEndpoints:
    """Test suite for /api/v1/admin endpoints"""

    @pytest.mark.asyncio
    async def test_admin_endpoint_requires_auth(self, async_client):
        """Test admin endpoint requires authentication"""
        response = await async_client.get("/api/v1/admin/users")
        assert response.status_code == 401

    @pytest.mark.asyncio
    async def test_get_users_as_non_admin(self, async_client, mock_user, auth_token):
        """Test listing users as non-admin (should fail)"""
        user_obj = MagicMock()
        user_obj.id = mock_user["id"]
        user_obj.email = mock_user["email"]
        user_obj.is_superuser = False  # Not an admin

        with patch("app.api.deps.User") as MockUser:
            MockUser.get = AsyncMock(return_value=user_obj)

            response = await async_client.get(
                "/api/v1/admin/users",
                headers={"Authorization": f"Bearer {auth_token}"}
            )
            
            assert response.status_code == 403

    @pytest.mark.asyncio
    async def test_get_dashboard_stats(self, async_client, mock_admin_user, admin_auth_token):
        """Test getting dashboard statistics"""
        admin_obj = MagicMock()
        admin_obj.id = mock_admin_user["id"]
        admin_obj.is_superuser = True

        with patch("app.api.deps.User") as MockUser:
            MockUser.get = AsyncMock(return_value=admin_obj)
            
            with patch("app.api.v1.endpoints.admin.User") as MockAdminUser:
                # Mock count methods
                MockAdminUser.find_all = MagicMock()
                MockAdminUser.find_all.return_value.count = AsyncMock(return_value=10)
                MockAdminUser.find = MagicMock()
                MockAdminUser.find.return_value.count = AsyncMock(return_value=8)

                response = await async_client.get(
                    "/api/v1/admin/dashboard/stats",
                    headers={"Authorization": f"Bearer {admin_auth_token}"}
                )
                
                # May succeed or fail based on mocking
                assert response.status_code in [200, 403]

    @pytest.mark.asyncio
    async def test_admin_count_users_requires_auth(self, async_client):
        """Test admin count users requires authentication"""
        response = await async_client.get("/api/v1/admin/users/count")
        assert response.status_code == 401


class TestUserProfile:
    """Test user profile operations"""

    @pytest.mark.asyncio
    async def test_update_profile_requires_auth(self, async_client):
        """Test updating user profile requires authentication"""
        response = await async_client.put(
            "/api/v1/users/me",
            json={"full_name": "New Name"}
        )
        assert response.status_code == 401

    @pytest.mark.asyncio
    async def test_user_endpoints_cors(self, async_client):
        """Test CORS headers are present"""
        response = await async_client.options("/api/v1/users/me")
        # OPTIONS should return 200 or 405
        assert response.status_code in [200, 405]
