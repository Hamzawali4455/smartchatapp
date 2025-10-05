part of 'ai_bloc.dart';

abstract class AiState extends Equatable {
  const AiState();

  @override
  List<Object?> get props => [];
}

class AiInitial extends AiState {}

class AiLoading extends AiState {}

class AiInitialized extends AiState {}

class SmartRepliesLoaded extends AiState {
  final List<String> replies;

  const SmartRepliesLoaded(this.replies);

  @override
  List<Object> get props => [replies];
}

class RelationshipInsightsLoaded extends AiState {
  final String insights;

  const RelationshipInsightsLoaded(this.insights);

  @override
  List<Object> get props => [insights];
}

class ConversationSummarized extends AiState {
  final String summary;

  const ConversationSummarized(this.summary);

  @override
  List<Object> get props => [summary];
}

class SentimentAnalyzed extends AiState {
  final Map<String, dynamic> analysis;

  const SentimentAnalyzed(this.analysis);

  @override
  List<Object> get props => [analysis];
}

class ConversationStartersGenerated extends AiState {
  final List<String> starters;

  const ConversationStartersGenerated(this.starters);

  @override
  List<Object> get props => [starters];
}

class AiError extends AiState {
  final String message;

  const AiError(this.message);

  @override
  List<Object> get props => [message];
}
