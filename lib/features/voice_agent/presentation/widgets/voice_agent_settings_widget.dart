import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/voice_agent_bloc.dart';

class VoiceAgentSettingsWidget extends StatefulWidget {
  const VoiceAgentSettingsWidget({super.key});

  @override
  State<VoiceAgentSettingsWidget> createState() => _VoiceAgentSettingsWidgetState();
}

class _VoiceAgentSettingsWidgetState extends State<VoiceAgentSettingsWidget> {
  final _apiKeyController = TextEditingController();
  final _agentIdController = TextEditingController();
  final _webhookUrlController = TextEditingController();
  
  String _selectedVoice = 'sarah';
  String _selectedLanguage = 'en-US';
  String _selectedPrompt = 'relationship';

  final List<String> _voices = [
    'sarah',
    'michael',
    'emma',
    'david',
    'lisa',
    'john',
    'sophia',
    'alex',
  ];

  final List<String> _languages = [
    'en-US',
    'en-GB',
    'es-ES',
    'fr-FR',
    'de-DE',
    'it-IT',
    'pt-BR',
    'ja-JP',
  ];

  final Map<String, String> _prompts = {
    'relationship': 'Relationship Assistant',
    'general': 'General Assistant',
    'chat': 'Chat Assistant',
  };

  @override
  Widget build(BuildContext context) {
    return BlocListener<VoiceAgentBloc, VoiceAgentState>(
      listener: (context, state) {
        if (state is VoiceAgentInitialized) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Voice Agent initialized successfully')),
          );
        } else if (state is VoiceAgentCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Voice Agent created successfully')),
          );
        } else if (state is VoiceAgentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // API Configuration
            _buildSectionTitle('API Configuration'),
            const SizedBox(height: 16),
            
            TextField(
              controller: _apiKeyController,
              decoration: const InputDecoration(
                labelText: 'Vapi API Key',
                hintText: 'Enter your Vapi API key',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _agentIdController,
              decoration: const InputDecoration(
                labelText: 'Agent ID',
                hintText: 'Enter your Vapi Agent ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            
            // Voice Settings
            _buildSectionTitle('Voice Settings'),
            const SizedBox(height: 16),
            
            DropdownButtonFormField<String>(
              value: _selectedVoice,
              decoration: const InputDecoration(
                labelText: 'Voice',
                border: OutlineInputBorder(),
              ),
              items: _voices.map((voice) {
                return DropdownMenuItem(
                  value: voice,
                  child: Text(voice.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedVoice = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              decoration: const InputDecoration(
                labelText: 'Language',
                border: OutlineInputBorder(),
              ),
              items: _languages.map((language) {
                return DropdownMenuItem(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            
            // Agent Type
            _buildSectionTitle('Agent Type'),
            const SizedBox(height: 16),
            
            DropdownButtonFormField<String>(
              value: _selectedPrompt,
              decoration: const InputDecoration(
                labelText: 'Agent Personality',
                border: OutlineInputBorder(),
              ),
              items: _prompts.entries.map((entry) {
                return DropdownMenuItem(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPrompt = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            
            // Webhook Configuration
            _buildSectionTitle('Webhook Configuration'),
            const SizedBox(height: 16),
            
            TextField(
              controller: _webhookUrlController,
              decoration: const InputDecoration(
                labelText: 'Webhook URL',
                hintText: 'https://your-webhook-url.com/vapi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _initializeAgent,
                    child: const Text('Initialize Agent'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _createAgent,
                    child: const Text('Create Agent'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (_webhookUrlController.text.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _setupWebhook,
                  child: const Text('Setup Webhook'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _initializeAgent() {
    if (_apiKeyController.text.isEmpty || _agentIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter API key and Agent ID')),
      );
      return;
    }

    context.read<VoiceAgentBloc>().add(InitializeVoiceAgent(
      apiKey: _apiKeyController.text,
      agentId: _agentIdController.text,
    ));
  }

  void _createAgent() {
    if (_apiKeyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter API key')),
      );
      return;
    }

    final prompt = _getPromptForType(_selectedPrompt);
    
    context.read<VoiceAgentBloc>().add(CreateVoiceAgent(
      name: 'SmartChat Voice Agent',
      prompt: prompt,
      voice: _selectedVoice,
      language: _selectedLanguage,
      settings: {
        'maxDuration': 300,
        'maxSilenceDuration': 10,
        'recordingEnabled': true,
        'transcriptionEnabled': true,
      },
    ));
  }

  void _setupWebhook() {
    if (_webhookUrlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter webhook URL')),
      );
      return;
    }

    context.read<VoiceAgentBloc>().add(SetupWebhook(
      webhookUrl: _webhookUrlController.text,
    ));
  }

  String _getPromptForType(String type) {
    switch (type) {
      case 'relationship':
        return '''You are a helpful voice assistant for SmartChat, a relationship-focused messaging app. Your role is to:
1. Help users with relationship advice and communication tips
2. Suggest conversation starters and topics
3. Provide emotional support and encouragement
4. Help users understand their communication patterns
5. Offer gentle guidance on relationship dynamics

Keep responses conversational, supportive, and under 30 seconds. Be warm, empathetic, and encouraging.''';
      case 'general':
        return '''You are a helpful voice assistant for SmartChat. You can help with:
1. General questions about the app
2. Feature explanations and tutorials
3. Technical support and guidance
4. User assistance and help

Be warm, helpful, and conversational. Keep responses natural and engaging.''';
      case 'chat':
        return '''You are a voice assistant for SmartChat. Your role is to:
1. Help users navigate the app features
2. Explain how to use Smart Streaks, Connection Suite, and other features
3. Provide technical support and guidance
4. Answer questions about the app's functionality
5. Help users customize their experience

Keep responses helpful, clear, and concise. Be friendly and professional.''';
      default:
        return 'You are a helpful voice assistant for SmartChat.';
    }
  }
}
