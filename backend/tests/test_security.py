"""
Tests for core security module
"""
import pytest
from datetime import datetime, timedelta

from app.core.security import (
    verify_password,
    get_password_hash,
    create_access_token,
    create_refresh_token,
    decode_token
)


class TestPasswordHashing:
    """Test password hashing functions"""

    def test_hash_password(self):
        """Test password hashing creates different hash"""
        password = "mysecretpassword"
        hashed = get_password_hash(password)
        
        assert hashed != password
        assert len(hashed) > 0

    def test_verify_password_correct(self):
        """Test correct password verification"""
        password = "mysecretpassword"
        hashed = get_password_hash(password)
        
        assert verify_password(password, hashed) == True

    def test_verify_password_incorrect(self):
        """Test incorrect password verification"""
        password = "mysecretpassword"
        wrong_password = "wrongpassword"
        hashed = get_password_hash(password)
        
        assert verify_password(wrong_password, hashed) == False

    def test_different_passwords_different_hashes(self):
        """Test different passwords produce different hashes"""
        hash1 = get_password_hash("password1")
        hash2 = get_password_hash("password2")
        
        assert hash1 != hash2

    def test_same_password_different_hashes(self):
        """Test same password produces different hashes (salt)"""
        password = "samepassword"
        hash1 = get_password_hash(password)
        hash2 = get_password_hash(password)
        
        # Hashes should be different due to salt
        assert hash1 != hash2
        # But both should verify correctly
        assert verify_password(password, hash1) == True
        assert verify_password(password, hash2) == True


class TestJWTTokens:
    """Test JWT token functions"""

    def test_create_access_token(self):
        """Test access token creation"""
        data = {"sub": "user123"}
        token = create_access_token(data)
        
        assert token is not None
        assert isinstance(token, str)
        assert len(token) > 0

    def test_create_refresh_token(self):
        """Test refresh token creation"""
        data = {"sub": "user123"}
        token = create_refresh_token(data)
        
        assert token is not None
        assert isinstance(token, str)
        assert len(token) > 0

    def test_access_and_refresh_tokens_different(self):
        """Test access and refresh tokens are different"""
        data = {"sub": "user123"}
        access_token = create_access_token(data)
        refresh_token = create_refresh_token(data)
        
        assert access_token != refresh_token

    def test_decode_valid_token(self):
        """Test decoding valid token"""
        user_id = "507f1f77bcf86cd799439011"
        data = {"sub": user_id}
        token = create_access_token(data)
        
        decoded = decode_token(token)
        
        assert decoded is not None
        assert decoded.get("sub") == user_id

    def test_decode_invalid_token(self):
        """Test decoding invalid token returns None"""
        invalid_token = "invalid.token.here"
        
        decoded = decode_token(invalid_token)
        
        assert decoded is None

    def test_token_with_custom_expiry(self):
        """Test token with custom expiry"""
        data = {"sub": "user123"}
        expires_delta = timedelta(hours=1)
        token = create_access_token(data, expires_delta)
        
        decoded = decode_token(token)
        
        assert decoded is not None
        assert "exp" in decoded


class TestConfigSettings:
    """Test configuration settings"""

    def test_settings_loaded(self):
        """Test settings are properly loaded"""
        from app.core.config import settings
        
        assert settings.PROJECT_NAME == "EMTOOLS"
        assert settings.VERSION is not None
        assert settings.API_V1_STR == "/api/v1"

    def test_settings_jwt_config(self):
        """Test JWT settings are configured"""
        from app.core.config import settings
        
        assert settings.SECRET_KEY is not None
        assert settings.ALGORITHM == "HS256"
        assert settings.ACCESS_TOKEN_EXPIRE_MINUTES > 0
        assert settings.REFRESH_TOKEN_EXPIRE_DAYS > 0

    def test_settings_cors_origins(self):
        """Test CORS origins are configured"""
        from app.core.config import settings
        
        assert len(settings.BACKEND_CORS_ORIGINS) > 0
        assert isinstance(settings.BACKEND_CORS_ORIGINS, list)

    def test_settings_mongodb_config(self):
        """Test MongoDB settings are configured"""
        from app.core.config import settings
        
        assert settings.MONGODB_URL is not None
        assert settings.MONGODB_DB_NAME is not None

    def test_settings_superuser_config(self):
        """Test first superuser settings"""
        from app.core.config import settings
        
        assert settings.FIRST_SUPERUSER_EMAIL is not None
        assert settings.FIRST_SUPERUSER_PASSWORD is not None


class TestPasswordEdgeCases:
    """Test edge cases for password handling"""

    def test_empty_password_hash(self):
        """Test hashing empty password (edge case)"""
        # Empty passwords should still produce a hash
        hashed = get_password_hash("")
        assert hashed is not None
        assert len(hashed) > 0

    def test_long_password_hash(self):
        """Test hashing long password"""
        long_password = "a" * 70  # 70 characters, within bcrypt limit
        hashed = get_password_hash(long_password)
        assert hashed is not None
        assert verify_password(long_password, hashed)

    def test_unicode_password(self):
        """Test password with unicode characters"""
        unicode_password = "пароль123!@#"  # Russian + numbers + symbols
        hashed = get_password_hash(unicode_password)
        assert verify_password(unicode_password, hashed)

    def test_special_characters_password(self):
        """Test password with many special characters"""
        special_password = "!@#$%^&*()_+-=[]{}|;':\",./<>?"
        hashed = get_password_hash(special_password)
        assert verify_password(special_password, hashed)
