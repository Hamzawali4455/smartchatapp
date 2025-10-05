part of 'voice_agent_bloc.dart';

abstract class VoiceAgentEvent extends Equatable {
  const VoiceAgentEvent();

  @override
  List<Object?> get props => [];
}

class InitializeVoiceAgent extends VoiceAgentEvent {
  final String apiKey;
  final String agentId;

  const InitializeVoiceAgent({
    required this.apiKey,
    required this.agentId,
  });

  @override
  List<Object> get props => [apiKey, agentId];
}

class StartVoiceCall extends VoiceAgentEvent {
  final String? phoneNumber;
  final String? userId;
  final Map<String, dynamic>? customData;

  const StartVoiceCall({
    this.phoneNumber,
    this.userId,
    this.customData,
  });

  @override
  List<Object?> get props => [phoneNumber, userId, customData];
}

class EndVoiceCall extends VoiceAgentEvent {
  final String callId;

  const EndVoiceCall(this.callId);

  @override
  List<Object> get props => [callId];
}

class GetCallStatus extends VoiceAgentEvent {
  final String callId;

  const GetCallStatus(this.callId);

  @override
  List<Object> get props => [callId];
}

class GetAgentDetails extends VoiceAgentEvent {
  const GetAgentDetails();
}

class CreateVoiceAgent extends VoiceAgentEvent {
  final String name;
  final String prompt;
  final String? voice;
  final String? language;
  final Map<String, dynamic>? settings;

  const CreateVoiceAgent({
    required this.name,
    required this.prompt,
    this.voice,
    this.language,
    this.settings,
  });

  @override
  List<Object?> get props => [name, prompt, voice, language, settings];
}

class UpdateVoiceAgent extends VoiceAgentEvent {
  final String agentId;
  final String? name;
  final String? prompt;
  final String? voice;
  final String? language;
  final Map<String, dynamic>? settings;

  const UpdateVoiceAgent({
    required this.agentId,
    this.name,
    this.prompt,
    this.voice,
    this.language,
    this.settings,
  });

  @override
  List<Object?> get props => [agentId, name, prompt, voice, language, settings];
}

class GetConversationHistory extends VoiceAgentEvent {
  final String callId;

  const GetConversationHistory(this.callId);

  @override
  List<Object> get props => [callId];
}

class SetupWebhook extends VoiceAgentEvent {
  final String webhookUrl;
  final List<String>? events;

  const SetupWebhook({
    required this.webhookUrl,
    this.events,
  });

  @override
  List<Object?> get props => [webhookUrl, events];
}
