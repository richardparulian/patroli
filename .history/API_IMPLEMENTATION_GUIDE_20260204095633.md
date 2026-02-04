# API Implementation Guide

Panduan implementasi Backend API yang sesuai dengan sistem Environment Management dan Authentication yang telah dibuat.

## 📋 API Requirements

### Backend API harus mendukung endpoints berikut:

#### 1. Authentication Endpoints

##### POST /auth/login
Login user dengan email dan password.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Success Response (200 OK):**
```json
{
  "user": {
    "id": "user-123",
    "name": "John Doe",
    "email": "user@example.com",
    "profile_picture": null,
    "phone": null,
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  },
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Error Response (401 Unauthorized):**
```json
{
  "message": "Invalid credentials",
  "error": "auth_failed"
}
```

##### POST /auth/register
Registrasi user baru.

**Request:**
```json
{
  "name": "John Doe",
  "email": "user@example.com",
  "password": "password123"
}
```

**Success Response (201 Created):**
```json
{
  "user": {
    "id": "user-456",
    "name": "John Doe",
    "email": "user@example.com",
    "profile_picture": null,
    "phone": null,
    "created_at": "2024-01-15T00:00:00Z",
    "updated_at": "2024-01-15T00:00:00Z"
  },
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Error Response (400 Bad Request):**
```json
{
  "message": "Email already exists",
  "error": "email_exists"
}
```

##### POST /auth/refresh
Refresh access token menggunakan refresh token.

**Request:**
```json
{
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Success Response (200 OK):**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Error Response (401 Unauthorized):**
```json
{
  "message": "Invalid or expired refresh token",
  "error": "refresh_failed"
}
```

## 🔒 Token Management

### Access Token
- Expiry: 15-30 menit (recommended)
- Header format: `Authorization: Bearer <token>`
- Digunakan untuk semua authenticated requests

### Refresh Token
- Expiry: 7-30 hari (recommended)
- Disimpan di secure storage
- Digunakan untuk refresh access token

### Token Validation
Backend harus memvalidasi:
1. Token signature
2. Token expiry
3. Token issuer (iss)
4. Token audience (aud)

## 📡 HTTP Headers

### Standard Headers untuk semua requests:
```
Content-Type: application/json
Accept: application/json
Authorization: Bearer <access_token>
```

## 🚨 Error Handling

### Standard Error Response Format:
```json
{
  "message": "Human readable error message",
  "error": "error_code"
}
```

### HTTP Status Codes:

#### Success Codes:
- **200 OK** - Request berhasil
- **201 Created** - Resource berhasil dibuat

#### Client Error Codes (4xx):
- **400 Bad Request** - Invalid request data
- **401 Unauthorized** - Tidak authenticated atau token invalid
- **403 Forbidden** - Tidak memiliki permission
- **404 Not Found** - Resource tidak ditemukan
- **422 Unprocessable Entity** - Validasi error
- **429 Too Many Requests** - Rate limit exceeded

#### Server Error Codes (5xx):
- **500 Internal Server Error** - Server error
- **502 Bad Gateway** - Gateway error
- **503 Service Unavailable** - Server sibuk atau maintenance

## 🔐 Security Recommendations

### 1. Token Security
- Gunakan JWT (JSON Web Tokens) dengan strong secret key
- Implementasi token expiry yang wajar (access: 15-30 min, refresh: 7-30 days)
- Rotasi refresh token setiap kali refresh
- Revoke old refresh tokens setelah refresh

### 2. API Security
- Selalu gunakan HTTPS di production
- Implementasi rate limiting
- Sanitasi semua input data
- Validasi data types dan lengths
- Implementasi CORS untuk web

### 3. Password Security
- Hash passwords dengan bcrypt/Argon2 (min cost factor 12)
- Minimum 8 karakter, 1 uppercase, 1 lowercase, 1 number
- Implementasi password strength checker
- Rate limit untuk login attempts

### 4. Additional Security (Production)
- Certificate pinning
- API key untuk mobile apps
- Request signing
- IP whitelisting jika perlu

## 🧪 Testing API

### Test dengan cURL:

```bash
# Test Login
curl -X POST https://api-dev.yourdomain.com/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'

# Test Register
curl -X POST https://api-dev.yourdomain.com/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"password123"}'

# Test Refresh Token
curl -X POST https://api-dev.yourdomain.com/auth/refresh \
  -H "Content-Type: application/json" \
  -d '{"refresh_token":"YOUR_REFRESH_TOKEN"}'
```

### Test dengan Postman/Insomnia:

1. Import environment variables dari `.env` file
2. Buat collections untuk auth endpoints
3. Test login dan simpan tokens
4. Gunakan token untuk authenticated requests
5. Test token refresh

## 📊 Database Schema (Example)

### Users Table:
```sql
CREATE TABLE users (
  id VARCHAR(255) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  profile_picture TEXT,
  phone VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### Refresh Tokens Table:
```sql
CREATE TABLE refresh_tokens (
  id VARCHAR(255) PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL,
  token VARCHAR(500) NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  revoked_at TIMESTAMP NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

## 🎯 Example Backend Implementations

### Node.js + Express + JWT
```javascript
const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const app = express();

// Login endpoint
app.post('/auth/login', async (req, res) => {
  const { email, password } = req.body;
  
  // Find user
  const user = await User.findOne({ where: { email } });
  
  // Verify password
  const isValid = await bcrypt.compare(password, user.password_hash);
  if (!isValid) {
    return res.status(401).json({ 
      message: 'Invalid credentials',
      error: 'auth_failed'
    });
  }
  
  // Generate tokens
  const accessToken = jwt.sign({ userId: user.id }, 
    process.env.JWT_SECRET, { expiresIn: '15m' });
  const refreshToken = jwt.sign({ userId: user.id },
    process.env.JWT_REFRESH_SECRET, { expiresIn: '7d' });
  
  res.json({
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      // ... other fields
    },
    access_token: accessToken,
    refresh_token: refreshToken
  });
});

// Refresh token endpoint
app.post('/auth/refresh', async (req, res) => {
  const { refresh_token } = req.body;
  
  try {
    const decoded = jwt.verify(refresh_token,
      process.env.JWT_REFRESH_SECRET);
    
    // Generate new tokens
    const accessToken = jwt.sign({ userId: decoded.userId },
      process.env.JWT_SECRET, { expiresIn: '15m' });
    const newRefreshToken = jwt.sign({ userId: decoded.userId },
      process.env.JWT_REFRESH_SECRET, { expiresIn: '7d' });
    
    // Revoke old refresh token
    await RefreshToken.update({ revoked_at: new Date() },
      { where: { token: refresh_token } });
    
    res.json({
      access_token: accessToken,
      refresh_token: newRefreshToken
    });
  } catch (error) {
    res.status(401).json({
      message: 'Invalid or expired refresh token',
      error: 'refresh_failed'
    });
  }
});
```

### Python + FastAPI + JWT
```python
from fastapi import FastAPI, HTTPException, Depends
from fastapi.security import OAuth2PasswordBearer
from jose import jwt, JWTError
from passlib.context import CryptContext
from datetime import datetime, timedelta

app = FastAPI()
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

@app.post("/auth/login")
async def login(email: str, password: str):
    # Find user
    user = await User.get_or_none(email=email)
    if not user:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    # Verify password
    if not pwd_context.verify(password, user.password_hash):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    # Generate tokens
    access_token_expires = timedelta(minutes=15)
    refresh_token_expires = timedelta(days=7)
    
    access_token = create_access_token(
        data={"sub": user.id}, expires_delta=access_token_expires
    )
    refresh_token = create_access_token(
        data={"sub": user.id}, expires_delta=refresh_token_expires
    )
    
    return {
        "user": {
            "id": user.id,
            "name": user.name,
            "email": user.email,
            # ... other fields
        },
        "access_token": access_token,
        "refresh_token": refresh_token
    }
```

## 🚀 Deployment Checklist

### Pre-Production:
- [ ] Update `.env.prod` dengan production API URL
- [ ] Ensure HTTPS enabled
- [ ] Implementasi rate limiting
- [ ] Setup monitoring dan logging
- [ ] Test refresh token flow
- [ ] Test error handling
- [ ] Verify CORS settings
- [ ] Backup database
- [ ] Setup database migrations
- [ ] Configure CDN untuk static assets

### Production:
- [ ] Disable debug mode
- [ ] Disable detailed error messages
- [ ] Enable request logging (for monitoring)
- [ ] Setup alerts untuk errors
- [ ] Monitor API performance
- [ ] Setup auto-scaling jika perlu
- [ ] Regular security audits
- [ ] Token rotation policy

## 📚 Additional Resources

- [JWT.io](https://jwt.io/) - Debug JWT tokens
- [OWASP Security Checklist](https://owasp.org/www-project-api-security/)
- [REST API Best Practices](https://restfulapi.net/)
- [Postman API Documentation](https://learning.postman.com/)

---

**Last Updated**: 2024-01-15
**Version**: 1.0.0
