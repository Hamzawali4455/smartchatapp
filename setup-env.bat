@echo off
echo Setting up SmartChat Environment...
echo.

REM Copy the example environment file to .env
copy env.example .env
echo ✅ Created .env file from env.example

echo.
echo 🔧 Next Steps:
echo 1. Edit the .env file with your actual credentials
echo 2. Update database connection details
echo 3. Add your API keys for external services
echo 4. Configure your cloud storage settings
echo.
echo 📝 Important Variables to Update:
echo - DATABASE_URL (PostgreSQL connection)
echo - REDIS_URL (Redis connection)
echo - JWT_SECRET (Generate a secure random string)
echo - ENCRYPTION_KEY (32-character encryption key)
echo - AWS credentials (if using S3)
echo - OpenAI API key (if using AI features)
echo.
echo 🚀 After updating .env, run: flutter pub get
echo.
pause
