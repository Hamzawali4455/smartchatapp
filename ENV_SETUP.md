# 🔧 SmartChat Environment Setup Guide

## Quick Start

1. **Run the setup script:**
   ```bash
   setup-env.bat
   ```

2. **Or manually copy the environment file:**
   ```bash
   copy env.example .env
   ```

## 📋 Required Environment Variables

### 🔴 **CRITICAL - Must Update These First**

```env
# Database (Required for app to work)
DATABASE_URL=postgresql://username:password@localhost:5432/smartchat_db
REDIS_URL=redis://localhost:6379

# Security (Required for authentication)
JWT_SECRET=your_super_secret_jwt_key_here_make_it_long_and_secure
ENCRYPTION_KEY=your_32_character_encryption_key_here
```

### 🟡 **IMPORTANT - Update for Full Functionality**

```env
# File Storage (For media uploads)
AWS_ACCESS_KEY_ID=your_aws_access_key_id
AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key
AWS_S3_BUCKET=smartchat-media

# AI Features (Optional but recommended)
OPENAI_API_KEY=your_openai_api_key_here
```

### 🟢 **OPTIONAL - For Advanced Features**

```env
# Push Notifications
FCM_SERVER_KEY=your_fcm_server_key

# Email Services
SMTP_USER=your_email@gmail.com
SMTP_PASS=your_app_password

# Social Login
GOOGLE_CLIENT_ID=your_google_client_id
FACEBOOK_APP_ID=your_facebook_app_id
```

## 🚀 Getting Started Steps

### 1. **Basic Setup (Minimum Required)**
```bash
# 1. Copy environment file
copy env.example .env

# 2. Generate secure keys
# Use online generators or run these commands:
# JWT_SECRET: Generate 64+ character random string
# ENCRYPTION_KEY: Generate exactly 32 character string

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

### 2. **Database Setup**
```bash
# Install PostgreSQL locally or use cloud service
# Update DATABASE_URL in .env file
# Example: postgresql://user:pass@localhost:5432/smartchat_db
```

### 3. **Redis Setup**
```bash
# Install Redis locally or use cloud service
# Update REDIS_URL in .env file
# Example: redis://localhost:6379
```

## 🔑 **How to Generate Secure Keys**

### JWT Secret (64+ characters)
```bash
# Option 1: Online generator
# Visit: https://generate-secret.vercel.app/64

# Option 2: Node.js
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"

# Option 3: PowerShell
[System.Web.Security.Membership]::GeneratePassword(64, 0)
```

### Encryption Key (32 characters)
```bash
# Option 1: Online generator
# Visit: https://generate-secret.vercel.app/32

# Option 2: Node.js
node -e "console.log(require('crypto').randomBytes(16).toString('hex'))"
```

## 🌐 **Cloud Services Setup**

### AWS S3 (File Storage)
1. Create AWS account: https://aws.amazon.com/
2. Create S3 bucket
3. Generate access keys
4. Update AWS variables in .env

### OpenAI (AI Features)
1. Create account: https://platform.openai.com/
2. Generate API key
3. Add to OPENAI_API_KEY in .env

### Firebase (Push Notifications)
1. Create project: https://console.firebase.google.com/
2. Enable Cloud Messaging
3. Download config files
4. Update FCM variables in .env

## 🗄️ **Database Options**

### Local Development
- **PostgreSQL**: Download from https://www.postgresql.org/download/
- **Redis**: Download from https://redis.io/download

### Cloud Hosting (Free Tiers)
- **Supabase**: https://supabase.com/ (PostgreSQL + Real-time)
- **Railway**: https://railway.app/ (PostgreSQL + Redis)
- **ElephantSQL**: https://www.elephantsql.com/ (PostgreSQL)
- **Redis Cloud**: https://redis.com/ (Redis)

## 🔧 **Environment Validation**

Create a simple validation script to check your setup:

```dart
// lib/core/config/env_validator.dart
class EnvValidator {
  static bool validate() {
    final requiredVars = [
      'DATABASE_URL',
      'REDIS_URL', 
      'JWT_SECRET',
      'ENCRYPTION_KEY',
    ];
    
    for (var varName in requiredVars) {
      if (Platform.environment[varName] == null) {
        print('❌ Missing required environment variable: $varName');
        return false;
      }
    }
    
    print('✅ All required environment variables are set');
    return true;
  }
}
```

## 🚨 **Security Best Practices**

1. **Never commit .env file to version control**
2. **Use strong, unique passwords**
3. **Rotate keys regularly**
4. **Use different keys for development/production**
5. **Enable 2FA on all cloud services**

## 📞 **Need Help?**

- Check the main README.md for detailed setup
- Review the API documentation
- Test with minimal configuration first
- Add advanced features gradually

---

**Happy coding!** 🚀
