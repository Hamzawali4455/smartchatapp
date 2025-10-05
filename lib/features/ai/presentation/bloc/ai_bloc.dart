import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/services/deepseek_service.dart';

part 'ai_event.dart';
part 'ai_state.dart';

class AiBloc extends Bloc<AiEvent, AiState> {
  final DeepSeekService _deepSeekService = DeepSeekService.instance;

  AiBloc() : super(AiInitial()) {
    on<InitializeAi>(_onInitializeAi);
    on<GetSmartReplies>(_onGetSmartReplies);
    on<GetRelationshipInsights>(_onGetRelationshipInsights);
    on<SummarizeConversation>(_onSummarizeConversation);
    on<AnalyzeSentiment>(_onAnalyzeSentiment);
    on<GenerateConversationStarters>(_onGenerateConversationStarters);
  }

  Future<void> _onInitializeAi(InitializeAi event, Emitter<AiState> emit) async {
    try {
      emit(AiLoading());
      
      _deepSeekService.initialize(event.apiKey);
      
      emit(AiInitialized());
    } catch (e) {
      emit(AiError('Failed to initialize AI: ${e.toString()}'));
    }
  }

  Future<void> _onGetSmartReplies(GetSmartReplies event, Emitter<AiState> emit) async {
    try {
      emit(AiLoading());
      
      final replies = await _deepSeekService.getSmartReplies(
        message: event.message,
        conversationHistory: event.conversationHistory,
      );
      
      emit(SmartRepliesLoaded(replies));
    } catch (e) {
      emit(AiError('Failed to get smart replies: ${e.toString()}'));
    }
  }

  Future<void> _onGetRelationshipInsights(GetRelationshipInsights event, Emitter<AiState> emit) async {
    try {
      emit(AiLoading());
      
      final insights = await _deepSeekService.getRelationshipInsights(
        message: event.message,
        conversationHistory: event.conversationHistory,
      );
      
      emit(RelationshipInsightsLoaded(insights));
    } catch (e) {
      emit(AiError('Failed to get relationship insights: ${e.toString()}'));
    }
  }

  Future<void> _onSummarizeConversation(SummarizeConversation event, Emitter<AiState> emit) async {
    try {
      emit(AiLoading());
      
      final summary = await _deepSeekService.summarizeConversation(
        messages: event.messages,
      );
      
      emit(ConversationSummarized(summary));
    } catch (e) {
      emit(AiError('Failed to summarize conversation: ${e.toString()}'));
    }
  }

  Future<void> _onAnalyzeSentiment(AnalyzeSentiment event, Emitter<AiState> emit) async {
    try {
      emit(AiLoading());
      
      final analysis = await _deepSeekService.analyzeSentiment(
        message: event.message,
      );
      
      emit(SentimentAnalyzed(analysis));
    } catch (e) {
      emit(AiError('Failed to analyze sentiment: ${e.toString()}'));
    }
  }

  Future<void> _onGenerateConversationStarters(GenerateConversationStarters event, Emitter<AiState> emit) async {
    try {
      emit(AiLoading());
      
      final starters = await _deepSeekService.generateConversationStarters(
        context: event.context,
      );
      
      emit(ConversationStartersGenerated(starters));
    } catch (e) {
      emit(AiError('Failed to generate conversation starters: ${e.toString()}'));
    }
  }
}
