import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/deepseek_config.dart';

class DeepSeekService {
  static DeepSeekService? _instance;
  static DeepSeekService get instance => _instance ??= DeepSeekService._();
  
  DeepSeekService._();
  
  String? _apiKey;
  
  /// Initialize DeepSeek service with API key
  void initialize(String apiKey) {
    _apiKey = apiKey;
  }
  
  /// Check if service is initialized
  bool get isInitialized => _apiKey != null;
  
  /// Get API key
  String get apiKey {
    if (_apiKey == null) {
      throw Exception('DeepSeek not initialized. Call initialize() first.');
    }
    return _apiKey!;
  }
  
  /// Make a chat completion request
  Future<Map<String, dynamic>> chatCompletion({
    required String message,
    String? systemPrompt,
    int? maxTokens,
    double? temperature,
    List<Map<String, String>>? conversationHistory,
  }) async {
    if (!isInitialized) {
      throw Exception('DeepSeek not initialized');
    }
    
    try {
      final messages = <Map<String, String>>[];
      
      // Add system prompt if provided
      if (systemPrompt != null) {
        messages.add({
          'role': 'system',
          'content': systemPrompt,
        });
      }
      
      // Add conversation history
      if (conversationHistory != null) {
        messages.addAll(conversationHistory);
      }
      
      // Add current message
      messages.add({
        'role': 'user',
        'content': message,
      });
      
      final requestBody = {
        'model': DeepSeekConfig.model,
        'messages': messages,
        'max_tokens': maxTokens ?? DeepSeekConfig.maxTokens,
        'temperature': temperature ?? DeepSeekConfig.temperature,
      };
      
      final response = await http.post(
        Uri.parse('${DeepSeekConfig.baseUrl}${DeepSeekConfig.chatEndpoint}'),
        headers: DeepSeekConfig.getHeaders(apiKey),
        body: jsonEncode(requestBody),
      ).timeout(Duration(seconds: DeepSeekConfig.timeoutSeconds));
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('DeepSeek API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('DeepSeek request failed: $e');
    }
  }
  
  /// Get smart reply suggestions
  Future<List<String>> getSmartReplies({
    required String message,
    List<Map<String, String>>? conversationHistory,
  }) async {
    try {
      final response = await chatCompletion(
        message: message,
        systemPrompt: DeepSeekConfig.smartReplyPrompt,
        conversationHistory: conversationHistory,
        maxTokens: 200,
        temperature: 0.8,
      );
      
      final content = response['choices'][0]['message']['content'] as String;
      final replies = content
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => line.replaceAll(RegExp(r'^\d+\.\s*'), '').trim())
          .toList();
      
      return replies.take(5).toList();
    } catch (e) {
      print('Error getting smart replies: $e');
      return [];
    }
  }
  
  /// Get relationship insights
  Future<String> getRelationshipInsights({
    required String message,
    List<Map<String, String>>? conversationHistory,
  }) async {
    try {
      final response = await chatCompletion(
        message: message,
        systemPrompt: DeepSeekConfig.relationshipAssistantPrompt,
        conversationHistory: conversationHistory,
        maxTokens: 300,
        temperature: 0.7,
      );
      
      return response['choices'][0]['message']['content'] as String;
    } catch (e) {
      print('Error getting relationship insights: $e');
      return 'Unable to provide insights at the moment.';
    }
  }
  
  /// Summarize conversation
  Future<String> summarizeConversation({
    required List<Map<String, String>> messages,
  }) async {
    try {
      final conversationText = messages
          .map((msg) => '${msg['role']}: ${msg['content']}')
          .join('\n');
      
      final response = await chatCompletion(
        message: conversationText,
        systemPrompt: DeepSeekConfig.messageSummaryPrompt,
        maxTokens: 200,
        temperature: 0.5,
      );
      
      return response['choices'][0]['message']['content'] as String;
    } catch (e) {
      print('Error summarizing conversation: $e');
      return 'Unable to summarize conversation at the moment.';
    }
  }
  
  /// Analyze message sentiment
  Future<Map<String, dynamic>> analyzeSentiment({
    required String message,
  }) async {
    try {
      final response = await chatCompletion(
        message: message,
        systemPrompt: DeepSeekConfig.sentimentAnalysisPrompt,
        maxTokens: 150,
        temperature: 0.3,
      );
      
      final content = response['choices'][0]['message']['content'] as String;
      
      // Parse sentiment from response
      String sentiment = 'neutral';
      if (content.toLowerCase().contains('positive')) {
        sentiment = 'positive';
      } else if (content.toLowerCase().contains('negative')) {
        sentiment = 'negative';
      }
      
      return {
        'sentiment': sentiment,
        'analysis': content,
        'confidence': 0.8, // Placeholder confidence score
      };
    } catch (e) {
      print('Error analyzing sentiment: $e');
      return {
        'sentiment': 'neutral',
        'analysis': 'Unable to analyze sentiment.',
        'confidence': 0.0,
      };
    }
  }
  
  /// Generate conversation starters
  Future<List<String>> generateConversationStarters({
    String? context,
  }) async {
    try {
      final message = context != null 
          ? 'Generate conversation starters for: $context'
          : 'Generate general conversation starters for a chat app';
      
      final response = await chatCompletion(
        message: message,
        systemPrompt: 'Generate 5 creative conversation starters for a chat app. Keep them engaging, appropriate, and under 20 words each.',
        maxTokens: 200,
        temperature: 0.9,
      );
      
      final content = response['choices'][0]['message']['content'] as String;
      final starters = content
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => line.replaceAll(RegExp(r'^\d+\.\s*'), '').trim())
          .toList();
      
      return starters.take(5).toList();
    } catch (e) {
      print('Error generating conversation starters: $e');
      return [
        'How was your day?',
        'What are you up to?',
        'Any exciting plans?',
        'How are you feeling?',
        'What\'s on your mind?',
      ];
    }
  }
}
