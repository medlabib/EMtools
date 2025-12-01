"""
Tests for paste endpoints
"""
import pytest
from unittest.mock import AsyncMock, MagicMock, patch
from datetime import datetime, timedelta


class TestPasteEndpoints:
    """Test suite for /api/v1/paste endpoints"""

    @pytest.mark.asyncio
    async def test_create_paste_success(self, async_client):
        """Test successful paste creation"""
        mock_paste = MagicMock()
        mock_paste.paste_id = "abc123xyz"
        mock_paste.title = "Test Paste"
        mock_paste.language = "python"
        mock_paste.is_protected = False
        mock_paste.expires_at = datetime.utcnow() + timedelta(hours=24)
        mock_paste.created_at = datetime.utcnow()
        mock_paste.insert = AsyncMock()

        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.return_value = mock_paste

            response = await async_client.post(
                "/api/v1/paste/",
                json={
                    "content": "print('Hello World')",
                    "title": "Test Paste",
                    "language": "python",
                    "expires_in_hours": 24,
                    "burn_after_read": False
                }
            )
            
            assert response.status_code == 201
            data = response.json()
            assert "paste_id" in data
            assert data["title"] == "Test Paste"
            assert data["language"] == "python"
            assert data["is_protected"] == False

    @pytest.mark.asyncio
    async def test_create_paste_with_password(self, async_client):
        """Test paste creation with password protection"""
        mock_paste = MagicMock()
        mock_paste.paste_id = "protected123"
        mock_paste.title = "Protected Paste"
        mock_paste.language = "text"
        mock_paste.is_protected = True
        mock_paste.expires_at = datetime.utcnow() + timedelta(hours=12)
        mock_paste.created_at = datetime.utcnow()
        mock_paste.insert = AsyncMock()

        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.return_value = mock_paste

            response = await async_client.post(
                "/api/v1/paste/",
                json={
                    "content": "Secret content",
                    "title": "Protected Paste",
                    "password": "mysecret123",
                    "expires_in_hours": 12
                }
            )
            
            assert response.status_code == 201
            data = response.json()
            assert data["is_protected"] == True

    @pytest.mark.asyncio
    async def test_create_paste_max_expiry(self, async_client):
        """Test paste expiry is capped at 24 hours"""
        mock_paste = MagicMock()
        mock_paste.paste_id = "capped123"
        mock_paste.title = None
        mock_paste.language = "text"
        mock_paste.is_protected = False
        mock_paste.expires_at = datetime.utcnow() + timedelta(hours=24)  # Should be capped
        mock_paste.created_at = datetime.utcnow()
        mock_paste.insert = AsyncMock()

        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.return_value = mock_paste

            response = await async_client.post(
                "/api/v1/paste/",
                json={
                    "content": "Test content",
                    "expires_in_hours": 24  # Max allowed is 24h
                }
            )
            
            assert response.status_code == 201

    @pytest.mark.asyncio
    async def test_create_paste_over_max_expiry(self, async_client, mock_paste):
        """Test that paste with expiry over 24h is rejected"""
        response = await async_client.post(
            "/api/v1/paste/",
            json={
                "content": "Test content",
                "expires_in_hours": 48  # Over max, should be rejected
            }
        )
        
        assert response.status_code == 422  # Validation error

    @pytest.mark.asyncio
    async def test_get_paste_info_success(self, async_client, mock_paste):
        """Test getting paste info"""
        paste_obj = MagicMock()
        paste_obj.paste_id = mock_paste["paste_id"]
        paste_obj.title = mock_paste["title"]
        paste_obj.language = mock_paste["language"]
        paste_obj.is_protected = mock_paste["is_protected"]
        paste_obj.expires_at = mock_paste["expires_at"]
        paste_obj.created_at = mock_paste["created_at"]
        paste_obj.views = 0
        paste_obj.max_views = None

        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.find_one = AsyncMock(return_value=paste_obj)

            response = await async_client.get(f"/api/v1/paste/{mock_paste['paste_id']}")
            
            assert response.status_code == 200
            data = response.json()
            assert data["paste_id"] == mock_paste["paste_id"]
            assert data["title"] == mock_paste["title"]

    @pytest.mark.asyncio
    async def test_get_paste_not_found(self, async_client):
        """Test getting non-existent paste"""
        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.find_one = AsyncMock(return_value=None)

            response = await async_client.get("/api/v1/paste/nonexistent123")
            
            assert response.status_code == 404
            assert "not found" in response.json()["detail"]

    @pytest.mark.asyncio
    async def test_get_paste_expired(self, async_client):
        """Test getting expired paste"""
        expired_paste = MagicMock()
        expired_paste.paste_id = "expired123"
        expired_paste.expires_at = datetime.utcnow() - timedelta(hours=1)  # Expired
        expired_paste.delete = AsyncMock()

        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.find_one = AsyncMock(return_value=expired_paste)

            response = await async_client.get("/api/v1/paste/expired123")
            
            assert response.status_code == 404
            assert "expired" in response.json()["detail"]

    @pytest.mark.asyncio
    async def test_get_paste_max_views_reached(self, async_client):
        """Test getting paste that reached max views"""
        maxed_paste = MagicMock()
        maxed_paste.paste_id = "maxed123"
        maxed_paste.expires_at = datetime.utcnow() + timedelta(hours=24)
        maxed_paste.views = 5
        maxed_paste.max_views = 5  # Max views reached
        maxed_paste.delete = AsyncMock()

        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.find_one = AsyncMock(return_value=maxed_paste)

            response = await async_client.get("/api/v1/paste/maxed123")
            
            assert response.status_code == 404
            assert "limit reached" in response.json()["detail"]

    @pytest.mark.asyncio
    async def test_create_paste_with_images(self, async_client):
        """Test paste creation with images"""
        mock_paste = MagicMock()
        mock_paste.paste_id = "withimages123"
        mock_paste.title = "Paste with Images"
        mock_paste.language = "text"
        mock_paste.is_protected = False
        mock_paste.expires_at = datetime.utcnow() + timedelta(hours=24)
        mock_paste.created_at = datetime.utcnow()
        mock_paste.insert = AsyncMock()

        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.return_value = mock_paste

            response = await async_client.post(
                "/api/v1/paste/",
                json={
                    "content": "Check out these images",
                    "title": "Paste with Images",
                    "expires_in_hours": 24,
                    "images": ["data:image/png;base64,abc123", "data:image/jpeg;base64,xyz789"]
                }
            )
            
            assert response.status_code == 201

    @pytest.mark.asyncio
    async def test_create_paste_burn_after_read(self, async_client):
        """Test paste with burn after read option"""
        mock_paste = MagicMock()
        mock_paste.paste_id = "burnme123"
        mock_paste.title = "Burn After Read"
        mock_paste.language = "text"
        mock_paste.is_protected = False
        mock_paste.expires_at = datetime.utcnow() + timedelta(hours=1)
        mock_paste.created_at = datetime.utcnow()
        mock_paste.insert = AsyncMock()

        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.return_value = mock_paste

            response = await async_client.post(
                "/api/v1/paste/",
                json={
                    "content": "This will self destruct",
                    "title": "Burn After Read",
                    "expires_in_hours": 1,
                    "burn_after_read": True
                }
            )
            
            assert response.status_code == 201


class TestPasteValidation:
    """Test paste input validation"""

    @pytest.mark.asyncio
    async def test_create_paste_missing_content(self, async_client):
        """Test creating paste without content field should fail"""
        response = await async_client.post(
            "/api/v1/paste/",
            json={
                "expires_in_hours": 1
            }
        )
        # Should return 422 for validation error
        assert response.status_code == 422

    @pytest.mark.asyncio
    async def test_create_paste_invalid_language(self, async_client):
        """Test creating paste with various language options"""
        mock_paste = MagicMock()
        mock_paste.paste_id = "lang123"
        mock_paste.title = "Code Paste"
        mock_paste.language = "python"
        mock_paste.is_protected = False
        mock_paste.expires_at = datetime.utcnow() + timedelta(hours=1)
        mock_paste.created_at = datetime.utcnow()
        mock_paste.insert = AsyncMock()

        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.return_value = mock_paste

            response = await async_client.post(
                "/api/v1/paste/",
                json={
                    "content": "print('hello')",
                    "title": "Python Code",
                    "language": "python",
                    "expires_in_hours": 1
                }
            )
            
            assert response.status_code == 201

    @pytest.mark.asyncio
    async def test_create_paste_with_max_views(self, async_client):
        """Test creating paste with max views limit"""
        mock_paste = MagicMock()
        mock_paste.paste_id = "maxview123"
        mock_paste.title = "Limited Views"
        mock_paste.language = "text"
        mock_paste.is_protected = False
        mock_paste.expires_at = datetime.utcnow() + timedelta(hours=1)
        mock_paste.created_at = datetime.utcnow()
        mock_paste.max_views = 5
        mock_paste.insert = AsyncMock()

        with patch("app.api.v1.endpoints.paste.Paste") as MockPaste:
            MockPaste.return_value = mock_paste

            response = await async_client.post(
                "/api/v1/paste/",
                json={
                    "content": "Limited viewing content",
                    "title": "Limited Views",
                    "expires_in_hours": 1,
                    "max_views": 5
                }
            )
            
            assert response.status_code == 201
