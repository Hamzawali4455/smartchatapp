part of 'voice_agent_bloc.dart';

abstract class VoiceAgentState extends Equatable {
  const VoiceAgentState();

  @override
  List<Object?> get props => [];
}

class VoiceAgentInitial extends VoiceAgentState {}

class VoiceAgentLoading extends VoiceAgentState {}

class VoiceAgentInitialized extends VoiceAgentState {}

class VoiceCallStarted extends VoiceAgentState {
  final Map<String, dynamic> callData;

  const VoiceCallStarted(this.callData);

  @override
  List<Object> get props => [callData];
}

class VoiceCallEnded extends VoiceAgentState {
  final Map<String, dynamic> callData;

  const VoiceCallEnded(this.callData);

  @override
  List<Object> get props => [callData];
}

class VoiceCallStatusUpdated extends VoiceAgentState {
  final Map<String, dynamic> status;

  const VoiceCallStatusUpdated(this.status);

  @override
  List<Object> get props => [status];
}

class VoiceAgentDetailsLoaded extends VoiceAgentState {
  final Map<String, dynamic> agent;

  const VoiceAgentDetailsLoaded(this.agent);

  @override
  List<Object> get props => [agent];
}

class VoiceAgentCreated extends VoiceAgentState {
  final Map<String, dynamic> agent;

  const VoiceAgentCreated(this.agent);

  @override
  List<Object> get props => [agent];
}

class VoiceAgentUpdated extends VoiceAgentState {
  final Map<String, dynamic> agent;

  const VoiceAgentUpdated(this.agent);

  @override
  List<Object> get props => [agent];
}

class VoiceConversationHistoryLoaded extends VoiceAgentState {
  final List<Map<String, dynamic>> history;

  const VoiceConversationHistoryLoaded(this.history);

  @override
  List<Object> get props => [history];
}

class VoiceWebhookSetup extends VoiceAgentState {
  final Map<String, dynamic> webhook;

  const VoiceWebhookSetup(this.webhook);

  @override
  List<Object> get props => [webhook];
}

class VoiceAgentError extends VoiceAgentState {
  final String message;

  const VoiceAgentError(this.message);

  @override
  List<Object> get props => [message];
}
