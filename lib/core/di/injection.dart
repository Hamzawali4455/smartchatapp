import 'package:get_it/get_it.dart';

// Import BLoCs
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/messaging/presentation/bloc/chat_bloc.dart';
import '../../features/connection/presentation/bloc/connection_bloc.dart';
import '../../features/ai/presentation/bloc/ai_bloc.dart';
import '../../features/voice_agent/presentation/bloc/voice_agent_bloc.dart';

// Import repositories (placeholder implementations)
import '../../features/auth/data/repositories/simple_auth_repository.dart';
import '../../features/chat/data/repositories/convex_chat_repository.dart';

// Import use cases
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/refresh_token_usecase.dart';
import '../../features/chat/domain/usecases/get_chats_usecase.dart';
import '../../features/chat/domain/usecases/get_messages_usecase.dart';
import '../../features/chat/domain/usecases/send_message_usecase.dart';
import '../../features/chat/domain/usecases/create_chat_usecase.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Register repositories
  getIt.registerLazySingleton<SimpleAuthRepository>(() => SimpleAuthRepository());
  getIt.registerLazySingleton<ConvexChatRepository>(() => ConvexChatRepository());
  
  // Register use cases
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: getIt<SimpleAuthRepository>()));
  getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(repository: getIt<SimpleAuthRepository>()));
  getIt.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(repository: getIt<SimpleAuthRepository>()));
  getIt.registerLazySingleton<RefreshTokenUseCase>(() => RefreshTokenUseCase(repository: getIt<SimpleAuthRepository>()));
  getIt.registerLazySingleton<GetChatsUseCase>(() => GetChatsUseCase(repository: getIt<ConvexChatRepository>()));
  getIt.registerLazySingleton<GetMessagesUseCase>(() => GetMessagesUseCase(repository: getIt<ConvexChatRepository>()));
  getIt.registerLazySingleton<SendMessageUseCase>(() => SendMessageUseCase(repository: getIt<ConvexChatRepository>()));
  getIt.registerLazySingleton<CreateChatUseCase>(() => CreateChatUseCase(repository: getIt<ConvexChatRepository>()));
  
  // Register BLoCs
  getIt.registerFactory<AuthBloc>(() => AuthBloc(
    loginUseCase: getIt<LoginUseCase>(),
    registerUseCase: getIt<RegisterUseCase>(),
    logoutUseCase: getIt<LogoutUseCase>(),
    refreshTokenUseCase: getIt<RefreshTokenUseCase>(),
  ));
  
  getIt.registerFactory<ChatBloc>(() => ChatBloc(
    getChatsUseCase: getIt<GetChatsUseCase>(),
    getMessagesUseCase: getIt<GetMessagesUseCase>(),
    sendMessageUseCase: getIt<SendMessageUseCase>(),
    createChatUseCase: getIt<CreateChatUseCase>(),
  ));
  
  getIt.registerFactory<ConnectionBloc>(() => ConnectionBloc());
  getIt.registerFactory<AiBloc>(() => AiBloc());
  getIt.registerFactory<VoiceAgentBloc>(() => VoiceAgentBloc());
}
