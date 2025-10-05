class AppConfig {
  static const String appName = 'SmartChat';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // API Configuration
  static const String baseUrl = 'https://api.smartchat.app';
  static const String wsUrl = 'wss://ws.smartchat.app';
  static const int apiTimeout = 30000;
  
  // Encryption Configuration
  static const String encryptionAlgorithm = 'AES-256-GCM';
  static const int keySize = 256;
  static const int ivSize = 12;
  
  // Storage Configuration
  static const String hiveBoxName = 'smart_chat_box';
  static const String userBoxName = 'user_box';
  static const String chatBoxName = 'chat_box';
  static const String messageBoxName = 'message_box';
  
  // Media Configuration
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB
  static const int maxVideoSize = 100 * 1024 * 1024; // 100MB
  static const int maxDocumentSize = 50 * 1024 * 1024; // 50MB
  static const int maxAudioDuration = 300; // 5 minutes
  
  // Streak Configuration
  static const int streakTimeoutMinutes = 3;
  static const int maxStreakLength = 3600; // 1 hour
  static const int streakRewardThreshold = 7;
  
  // AI Configuration
  static const String aiModelPath = 'assets/models/relationship_ai.tflite';
  static const int aiProcessingTimeout = 5000;
  
  // Security Configuration
  static const int maxLoginAttempts = 5;
  static const int sessionTimeout = 86400; // 24 hours
  static const int biometricTimeout = 300; // 5 minutes
  
  // Animation Configuration
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);
  
  // Feature Flags
  static const bool enableARFeatures = true;
  static const bool enableVoiceFeatures = true;
  static const bool enableAIFeatures = true;
  static const bool enableConnectionSuite = true;
  static const bool enableAdvancedSecurity = true;
}
