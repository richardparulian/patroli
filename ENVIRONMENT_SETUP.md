# Environment Setup Guide

Panduan untuk setup dan penggunaan environment management di proyek Flutter POS.

## 📋 Overview

Proyek ini menggunakan sistem environment management dengan 3 environment:
- **dev** - Development environment
- **staging** - Staging/UAT environment
- **prod** - Production environment

## 🔧 Setup Awal

### 1. Install Dependencies

Jalankan perintah berikut untuk install dependencies baru:

```bash
flutter pub get
```

### 2. Generate Environment Code

Run code generation untuk generate file `env.g.dart`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Generate Network Providers Code

Generate network providers code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📁 Struktur Environment

Environment files terletak di:
```
lib/config/environment/
├── .env            # Default environment
├── .env.dev        # Development
├── .env.staging    # Staging
└── .env.prod       # Production
```

## ⚙️ Konfigurasi Environment

### Environment Variables

Setiap environment file memiliki variabel berikut:

```env
# Environment Type
ENV=dev|staging|prod

# App Configuration
APP_NAME=Flutter POS

# API Configuration
API_BASE_URL=https://api.yourdomain.com
API_TIMEOUT=30000

# Feature Flags
ENABLE_DEBUG=true
ENABLE_LOGGING=true
```

### Cara Mengganti Environment

#### Option 1: Copy Environment File

Untuk menggunakan environment tertentu:

```bash
# Development
cp lib/config/environment/.env.dev lib/config/environment/.env

# Staging
cp lib/config/environment/.env.staging lib/config/environment/.env

# Production
cp lib/config/environment/.env.prod lib/config/environment/.env
```

#### Option 2: Simlink (Recommended for Development)

Buat simlink untuk environment yang aktif:

```bash
# Linux/Mac
ln -sf lib/config/environment/.env.dev lib/config/environment/.env

# Windows
mklink /H lib\config\environment\.env lib\config\environment\.env.dev
```

#### Option 3: Build Configuration (For CI/CD)

Gunakan environment variable saat build:

```bash
# Build untuk development
flutter build apk --dart-define=ENV=dev

# Build untuk staging
flutter build apk --dart-define=ENV=staging

# Build untuk production
flutter build apk --dart-define=ENV=prod
```

## 🔌 Penggunaan di Code

### Menggunakan AppConfig Class

```dart
import 'package:pos/config/app_config.dart';

// Cek environment
if (AppConfig.isDevelopment) {
  // Development-only logic
} else if (AppConfig.isProduction) {
  // Production-only logic
}

// Dapatkan API base URL
final apiUrl = AppConfig.apiBaseUrl;

// Cek debug mode
if (AppConfig.isDebugEnabled) {
  // Debug logic
}
```

### Menggunakan Env Class

```dart
import 'package:pos/config/env.dart';

// Dapatkan nilai langsung dari Env
final appName = Env.appName;
final apiUrl = Env.apiBaseUrl;
```

## 🔐 API Configuration

### Authentication Flow

Sistem autentikasi menggunakan flow berikut:

1. **Login/Register**: Token dan refresh token disimpan di SecureStorage
2. **API Request**: AuthInterceptor menambahkan Bearer token ke setiap request
3. **Token Expired (401)**: AuthInterceptor otomatis refresh token
4. **Refresh Failed**: User di-logout dan tokens dihapus

### API Response Format

#### Success Response

```json
{
  "user": {
    "id": "user-123",
    "name": "John Doe",
    "email": "john@example.com",
    "profile_picture": null,
    "phone": null,
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  },
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIs..."
}
```

#### Error Response

```json
{
  "message": "Invalid credentials",
  "error": "auth_failed"
}
```

## 🔌 API Endpoints

### Authentication Endpoints

#### Login
```
POST /auth/login
Content-Type: application/json

Request Body:
{
  "email": "user@example.com",
  "password": "password123"
}

Response: 200 OK
{
  "user": {...},
  "access_token": "...",
  "refresh_token": "..."
}
```

#### Register
```
POST /auth/register
Content-Type: application/json

Request Body:
{
  "name": "John Doe",
  "email": "user@example.com",
  "password": "password123"
}

Response: 201 Created
{
  "user": {...},
  "access_token": "...",
  "refresh_token": "..."
}
```

#### Refresh Token
```
POST /auth/refresh
Content-Type: application/json

Request Body:
{
  "refresh_token": "..."
}

Response: 200 OK
{
  "access_token": "...",
  "refresh_token": "..."
}
```

## 🔧 Troubleshooting

### Error: Could not load .env file

**Solution**: Pastikan file `.env` ada di `lib/config/environment/`

```bash
ls lib/config/environment/
```

### Error: Env class not found

**Solution**: Generate code environment dengan build_runner:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Error: Network request failed

**Solution**: Cek konfigurasi API Base URL di environment file:

```bash
cat lib/config/environment/.env
```

Pastikan URL valid dan bisa diakses.

### Token tidak tersimpan

**Solution**: Pastikan SecureStorage tersedia di device. Di Android/iOS simulator, mungkin ada issue dengan SecureStorage. Gunakan real device untuk testing.

## 🚀 Best Practices

### 1. Environment Variables
- Jangan commit file `.env.prod` ke version control
- Gunakan `.env.dev` sebagai default untuk development
- Simpan production config di CI/CD secrets

### 2. API Security
- Selalu gunakan HTTPS di production
- Implementasi certificate pinning jika perlu
- Validasi semua input di server

### 3. Token Management
- Token disimpan di SecureStorage (encrypted)
- Refresh token di-generate ulang setiap kali refresh
- Logout menghapus semua tokens dari storage

### 4. Error Handling
- Semua error dikonversi ke Failure objects
- User-friendly error messages
- Proper logging untuk debugging

## 📝 Example Scenarios

### Scenario 1: Setup Development Environment

```bash
# 1. Copy dev environment
cp lib/config/environment/.env.dev lib/config/environment/.env

# 2. Update API URL jika perlu
nano lib/config/environment/.env

# 3. Generate environment code
dart run build_runner build --delete-conflicting-outputs

# 4. Run app
flutter run
```

### Scenario 2: Setup Production Build

```bash
# 1. Copy prod environment
cp lib/config/environment/.env.prod lib/config/environment/.env

# 2. Generate environment code
dart run build_runner build --delete-conflicting-outputs

# 3. Build APK
flutter build apk --release

# 4. Build iOS (di macOS)
flutter build ios --release
```

### Scenario 3: Update API Base URL

```bash
# Edit .env file sesuai environment yang aktif
nano lib/config/environment/.env

# Update API_BASE_URL
API_BASE_URL=https://api-new.yourdomain.com

# Restart app (atau hot reload tidak akan reload environment)
flutter run
```

## 🔗 Related Documentation

- [API Documentation](./API_DOCUMENTATION.md)
- [Architecture Guide](./lib/core/generators/ARCHITECTURE_GUIDE.md)
- [Testing Guide](./TESTING_GUIDE.md)

## 📞 Support

Jika ada issues dengan environment setup:
1. Cek logs di console saat app startup
2. Pastikan environment file valid
3. Run `flutter clean && flutter pub get`
4. Generate ulang environment code

---

**Last Updated**: 2024-01-15
**Version**: 1.0.0
