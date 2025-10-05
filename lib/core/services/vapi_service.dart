import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/vapi_config.dart';

class VapiService {
  static VapiService? _instance;
  static VapiService get instance => _instance ??= VapiService._();
  
  VapiService._();
  
  String? _apiKey;
  String? _agentId;
  
  /// Initialize Vapi service with API key and agent ID
  void initialize(String apiKey, String agentId) {
    _apiKey = apiKey;
    _agentId = agentId;
  }
  
  /// Check if service is initialized
  bool get isInitialized => _apiKey != null && _agentId != null;
  
  /// Get API key
  String get apiKey {
    if (_apiKey == null) {
      throw Exception('Vapi not initialized. Call initialize() first.');
    }
    return _apiKey!;
  }
  
  /// Get agent ID
  String get agentId {
    if (_agentId == null) {
      throw Exception('Vapi not initialized. Call initialize() first.');
    }
    return _agentId!;
  }
  
  /// Start a voice call
  Future<Map<String, dynamic>> startCall({
    String? phoneNumber,
    String? userId,
    Map<String, dynamic>? customData,
  }) async {
    if (!isInitialized) {
      throw Exception('Vapi not initialized');
    }
    
    try {
      final requestBody = {
        'agentId': agentId,
        'phoneNumber': phoneNumber,
        'customData': customData ?? {},
        'maxDuration': VapiConfig.maxCallDuration,
        'maxSilenceDuration': VapiConfig.maxSilenceDuration,
        'recordingEnabled': VapiConfig.enableRecording,
        'transcriptionEnabled': VapiConfig.enableTranscription,
      };
      
      final response = await http.post(
        Uri.parse('${VapiConfig.baseUrl}${VapiConfig.callsEndpoint}'),
        headers: VapiConfig.getHeaders(apiKey),
        body: jsonEncode(requestBody),
      ).timeout(Duration(seconds: VapiConfig.timeoutSeconds));
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Vapi API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Vapi call start failed: $e');
    }
  }
  
  /// End a voice call
  Future<Map<String, dynamic>> endCall(String callId) async {
    if (!isInitialized) {
      throw Exception('Vapi not initialized');
    }
    
    try {
      final response = await http.post(
        Uri.parse('${VapiConfig.baseUrl}${VapiConfig.callsEndpoint}/$callId/end'),
        headers: VapiConfig.getHeaders(apiKey),
      ).timeout(Duration(seconds: VapiConfig.timeoutSeconds));
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Vapi API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Vapi call end failed: $e');
    }
  }
  
  /// Get call status
  Future<Map<String, dynamic>> getCallStatus(String callId) async {
    if (!isInitialized) {
      throw Exception('Vapi not initialized');
    }
    
    try {
      final response = await http.get(
        Uri.parse('${VapiConfig.baseUrl}${VapiConfig.callsEndpoint}/$callId'),
        headers: VapiConfig.getHeaders(apiKey),
      ).timeout(Duration(seconds: VapiConfig.timeoutSeconds));
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Vapi API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Vapi call status failed: $e');
    }
  }
  
  /// Get agent details
  Future<Map<String, dynamic>> getAgent() async {
    if (!isInitialized) {
      throw Exception('Vapi not initialized');
    }
    
    try {
      final response = await http.get(
        Uri.parse('${VapiConfig.baseUrl}${VapiConfig.agentsEndpoint}/$agentId'),
        headers: VapiConfig.getHeaders(apiKey),
      ).timeout(Duration(seconds: VapiConfig.timeoutSeconds));
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Vapi API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Vapi agent fetch failed: $e');
    }
  }
  
  /// Create a new agent
  Future<Map<String, dynamic>> createAgent({
    required String name,
    required String prompt,
    String? voice,
    String? language,
    Map<String, dynamic>? settings,
  }) async {
    if (!isInitialized) {
      throw Exception('Vapi not initialized');
    }
    
    try {
      final requestBody = {
        'name': name,
        'prompt': prompt,
        'voice': voice ?? VapiConfig.defaultVoice,
        'language': language ?? VapiConfig.defaultLanguage,
        'settings': settings ?? {},
      };
      
      final response = await http.post(
        Uri.parse('${VapiConfig.baseUrl}${VapiConfig.agentsEndpoint}'),
        headers: VapiConfig.getHeaders(apiKey),
        body: jsonEncode(requestBody),
      ).timeout(Duration(seconds: VapiConfig.timeoutSeconds));
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Vapi API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Vapi agent creation failed: $e');
    }
  }
  
  /// Update agent
  Future<Map<String, dynamic>> updateAgent({
    required String agentId,
    String? name,
    String? prompt,
    String? voice,
    String? language,
    Map<String, dynamic>? settings,
  }) async {
    if (!isInitialized) {
      throw Exception('Vapi not initialized');
    }
    
    try {
      final requestBody = <String, dynamic>{};
      if (name != null) requestBody['name'] = name;
      if (prompt != null) requestBody['prompt'] = prompt;
      if (voice != null) requestBody['voice'] = voice;
      if (language != null) requestBody['language'] = language;
      if (settings != null) requestBody['settings'] = settings;
      
      final response = await http.patch(
        Uri.parse('${VapiConfig.baseUrl}${VapiConfig.agentsEndpoint}/$agentId'),
        headers: VapiConfig.getHeaders(apiKey),
        body: jsonEncode(requestBody),
      ).timeout(Duration(seconds: VapiConfig.timeoutSeconds));
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Vapi API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Vapi agent update failed: $e');
    }
  }
  
  /// Get conversation history
  Future<List<Map<String, dynamic>>> getConversationHistory(String callId) async {
    if (!isInitialized) {
      throw Exception('Vapi not initialized');
    }
    
    try {
      final response = await http.get(
        Uri.parse('${VapiConfig.baseUrl}${VapiConfig.conversationsEndpoint}?callId=$callId'),
        headers: VapiConfig.getHeaders(apiKey),
      ).timeout(Duration(seconds: VapiConfig.timeoutSeconds));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['conversations'] ?? []);
      } else {
        throw Exception('Vapi API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Vapi conversation history failed: $e');
    }
  }
  
  /// Setup webhook for call events
  Future<Map<String, dynamic>> setupWebhook({
    required String webhookUrl,
    List<String>? events,
  }) async {
    if (!isInitialized) {
      throw Exception('Vapi not initialized');
    }
    
    try {
      final requestBody = {
        'url': webhookUrl,
        'events': events ?? [
          VapiConfig.callStartedEvent,
          VapiConfig.callEndedEvent,
          VapiConfig.messageReceivedEvent,
          VapiConfig.messageSentEvent,
          VapiConfig.transcriptionReceivedEvent,
          VapiConfig.errorEvent,
        ],
      };
      
      final response = await http.post(
        Uri.parse('${VapiConfig.baseUrl}${VapiConfig.webhooksEndpoint}'),
        headers: VapiConfig.getHeaders(apiKey),
        body: jsonEncode(requestBody),
      ).timeout(Duration(seconds: VapiConfig.timeoutSeconds));
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Vapi API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Vapi webhook setup failed: $e');
    }
  }
}
