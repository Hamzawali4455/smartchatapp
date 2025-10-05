part of 'ai_bloc.dart';

abstract class AiEvent extends Equatable {
  const AiEvent();

  @override
  List<Object?> get props => [];
}

class InitializeAi extends AiEvent {
  final String apiKey;

  const InitializeAi(this.apiKey);

  @override
  List<Object> get props => [apiKey];
}

class GetSmartReplies extends AiEvent {
  final String message;
  final List<Map<String, String>>? conversationHistory;

  const GetSmartReplies({
    required this.message,
    this.conversationHistory,
  });

  @override
  List<Object?> get props => [message, conversationHistory];
}

class GetRelationshipInsights extends AiEvent {
  final String message;
  final List<Map<String, String>>? conversationHistory;

  const GetRelationshipInsights({
    required this.message,
    this.conversationHistory,
  });

  @override
  List<Object?> get props => [message, conversationHistory];
}

class SummarizeConversation extends AiEvent {
  final List<Map<String, String>> messages;

  const SummarizeConversation(this.messages);

  @override
  List<Object> get props => [messages];
}

class AnalyzeSentiment extends AiEvent {
  final String message;

  const AnalyzeSentiment(this.message);

  @override
  List<Object> get props => [message];
}

class GenerateConversationStarters extends AiEvent {
  final String? context;

  const GenerateConversationStarters({this.context});

  @override
  List<Object?> get props => [context];
}
