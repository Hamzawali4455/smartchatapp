import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';

import 'core/config/app_config.dart';
import 'core/config/convex_config.dart';
import 'core/di/injection.dart';
import 'core/services/convex_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_router.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/messaging/presentation/bloc/chat_bloc.dart';
import 'features/connection/presentation/bloc/connection_bloc.dart';
import 'features/ai/presentation/bloc/ai_bloc.dart';
import 'features/voice_agent/presentation/bloc/voice_agent_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Initialize Convex for real-time backend
  await ConvexService.instance.initialize();
  
  // Initialize dependency injection
  await configureDependencies();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const SmartChatApp());
}

class SmartChatApp extends StatelessWidget {
  const SmartChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.instance<AuthBloc>()),
        BlocProvider(create: (context) => GetIt.instance<ChatBloc>()),
        BlocProvider(create: (context) => GetIt.instance<ConnectionBloc>()),
        BlocProvider(create: (context) => AiBloc()),
        BlocProvider(create: (context) => VoiceAgentBloc()),
      ],
      child: MaterialApp.router(
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      ),
    );
  }
}
