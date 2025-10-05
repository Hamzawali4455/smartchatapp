import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/services/vapi_service.dart';

part 'voice_agent_event.dart';
part 'voice_agent_state.dart';

class VoiceAgentBloc extends Bloc<VoiceAgentEvent, VoiceAgentState> {
  final VapiService _vapiService = VapiService.instance;

  VoiceAgentBloc() : super(VoiceAgentInitial()) {
    on<InitializeVoiceAgent>(_onInitializeVoiceAgent);
    on<StartVoiceCall>(_onStartVoiceCall);
    on<EndVoiceCall>(_onEndVoiceCall);
    on<GetCallStatus>(_onGetCallStatus);
    on<GetAgentDetails>(_onGetAgentDetails);
    on<CreateVoiceAgent>(_onCreateVoiceAgent);
    on<UpdateVoiceAgent>(_onUpdateVoiceAgent);
    on<GetConversationHistory>(_onGetConversationHistory);
    on<SetupWebhook>(_onSetupWebhook);
  }

  Future<void> _onInitializeVoiceAgent(InitializeVoiceAgent event, Emitter<VoiceAgentState> emit) async {
    try {
      emit(VoiceAgentLoading());
      
      _vapiService.initialize(event.apiKey, event.agentId);
      
      emit(VoiceAgentInitialized());
    } catch (e) {
      emit(VoiceAgentError('Failed to initialize voice agent: ${e.toString()}'));
    }
  }

  Future<void> _onStartVoiceCall(StartVoiceCall event, Emitter<VoiceAgentState> emit) async {
    try {
      emit(VoiceAgentLoading());
      
      final callData = await _vapiService.startCall(
        phoneNumber: event.phoneNumber,
        userId: event.userId,
        customData: event.customData,
      );
      
      emit(VoiceCallStarted(callData));
    } catch (e) {
      emit(VoiceAgentError('Failed to start voice call: ${e.toString()}'));
    }
  }

  Future<void> _onEndVoiceCall(EndVoiceCall event, Emitter<VoiceAgentState> emit) async {
    try {
      emit(VoiceAgentLoading());
      
      final callData = await _vapiService.endCall(event.callId);
      
      emit(VoiceCallEnded(callData));
    } catch (e) {
      emit(VoiceAgentError('Failed to end voice call: ${e.toString()}'));
    }
  }

  Future<void> _onGetCallStatus(GetCallStatus event, Emitter<VoiceAgentState> emit) async {
    try {
      emit(VoiceAgentLoading());
      
      final status = await _vapiService.getCallStatus(event.callId);
      
      emit(VoiceCallStatusUpdated(status));
    } catch (e) {
      emit(VoiceAgentError('Failed to get call status: ${e.toString()}'));
    }
  }

  Future<void> _onGetAgentDetails(GetAgentDetails event, Emitter<VoiceAgentState> emit) async {
    try {
      emit(VoiceAgentLoading());
      
      final agent = await _vapiService.getAgent();
      
      emit(VoiceAgentDetailsLoaded(agent));
    } catch (e) {
      emit(VoiceAgentError('Failed to get agent details: ${e.toString()}'));
    }
  }

  Future<void> _onCreateVoiceAgent(CreateVoiceAgent event, Emitter<VoiceAgentState> emit) async {
    try {
      emit(VoiceAgentLoading());
      
      final agent = await _vapiService.createAgent(
        name: event.name,
        prompt: event.prompt,
        voice: event.voice,
        language: event.language,
        settings: event.settings,
      );
      
      emit(VoiceAgentCreated(agent));
    } catch (e) {
      emit(VoiceAgentError('Failed to create voice agent: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateVoiceAgent(UpdateVoiceAgent event, Emitter<VoiceAgentState> emit) async {
    try {
      emit(VoiceAgentLoading());
      
      final agent = await _vapiService.updateAgent(
        agentId: event.agentId,
        name: event.name,
        prompt: event.prompt,
        voice: event.voice,
        language: event.language,
        settings: event.settings,
      );
      
      emit(VoiceAgentUpdated(agent));
    } catch (e) {
      emit(VoiceAgentError('Failed to update voice agent: ${e.toString()}'));
    }
  }

  Future<void> _onGetConversationHistory(GetConversationHistory event, Emitter<VoiceAgentState> emit) async {
    try {
      emit(VoiceAgentLoading());
      
      final history = await _vapiService.getConversationHistory(event.callId);
      
      emit(VoiceConversationHistoryLoaded(history));
    } catch (e) {
      emit(VoiceAgentError('Failed to get conversation history: ${e.toString()}'));
    }
  }

  Future<void> _onSetupWebhook(SetupWebhook event, Emitter<VoiceAgentState> emit) async {
    try {
      emit(VoiceAgentLoading());
      
      final webhook = await _vapiService.setupWebhook(
        webhookUrl: event.webhookUrl,
        events: event.events,
      );
      
      emit(VoiceWebhookSetup(webhook));
    } catch (e) {
      emit(VoiceAgentError('Failed to setup webhook: ${e.toString()}'));
    }
  }
}
