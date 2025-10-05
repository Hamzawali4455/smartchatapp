class VapiConfig {
  // Vapi API Configuration
  static const String baseUrl = 'https://api.vapi.ai';
  static const int timeoutSeconds = 30;
  
  // API Endpoints
  static const String callsEndpoint = '/call';
  static const String agentsEndpoint = '/agent';
  static const String webhooksEndpoint = '/webhook';
  static const String conversationsEndpoint = '/conversation';
  
  // Request Headers
  static Map<String, String> getHeaders(String apiKey) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
  }
  
  // Voice Agent Settings
  static const String defaultVoice = 'sarah';
  static const String defaultLanguage = 'en-US';
  static const double defaultSpeed = 1.0;
  static const double defaultPitch = 1.0;
  
  // Call Settings
  static const int maxCallDuration = 300; // 5 minutes
  static const int maxSilenceDuration = 10; // 10 seconds
  static const bool enableRecording = true;
  static const bool enableTranscription = true;
  
  // Webhook Events
  static const String callStartedEvent = 'call-started';
  static const String callEndedEvent = 'call-ended';
  static const String messageReceivedEvent = 'message-received';
  static const String messageSentEvent = 'message-sent';
  static const String transcriptionReceivedEvent = 'transcription-received';
  static const String errorEvent = 'error';
  
  // SmartChat Voice Agent Prompts
  static const String relationshipAssistantPrompt = '''
You are a helpful voice assistant for SmartChat, a relationship-focused messaging app. Your role is to:

1. Help users with relationship advice and communication tips
2. Suggest conversation starters and topics
3. Provide emotional support and encouragement
4. Help users understand their communication patterns
5. Offer gentle guidance on relationship dynamics

Keep responses conversational, supportive, and under 30 seconds. Be warm, empathetic, and encouraging.
''';

  static const String chatAssistantPrompt = '''
You are a voice assistant for SmartChat. Your role is to:

1. Help users navigate the app features
2. Explain how to use Smart Streaks, Connection Suite, and other features
3. Provide technical support and guidance
4. Answer questions about the app's functionality
5. Help users customize their experience

Keep responses helpful, clear, and concise. Be friendly and professional.
''';

  static const String generalAssistantPrompt = '''
You are a helpful voice assistant for SmartChat. You can help with:

1. General questions about the app
2. Relationship and communication advice
3. Feature explanations and tutorials
4. Emotional support and encouragement
5. Conversation starters and topics

Be warm, helpful, and conversational. Keep responses natural and engaging.
''';
}
