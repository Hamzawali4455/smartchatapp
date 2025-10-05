class ConvexConfig {
  // Convex deployment URL
  static const String deploymentUrl = 'https://brainy-turtle-357.convex.cloud';
  
  // API endpoints
  static const String baseUrl = 'https://brainy-turtle-357.convex.cloud';
  
  // Real-time configuration
  static const int heartbeatInterval = 25000;
  static const int heartbeatTimeout = 60000;
  
  // File upload limits
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB
  static const int maxVideoSize = 100 * 1024 * 1024; // 100MB
  static const int maxDocumentSize = 50 * 1024 * 1024; // 50MB
  
  // Streak configuration
  static const int defaultStreakTimeoutMinutes = 3;
  static const int maxStreakLength = 3600; // 1 hour
  
  // Connection suite timeouts
  static const int breathingSessionTimeout = 300; // 5 minutes
  static const int musicSessionTimeout = 1800; // 30 minutes
  static const int sharedRoomTimeout = 3600; // 1 hour
}
