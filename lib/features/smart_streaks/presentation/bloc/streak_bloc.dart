import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/streak_entity.dart';
import '../../domain/usecases/create_streak_usecase.dart';
import '../../domain/usecases/get_streaks_usecase.dart';
import '../../domain/usecases/view_streak_usecase.dart';
import '../../domain/usecases/save_streak_usecase.dart';
import '../../domain/usecases/react_to_streak_usecase.dart';

part 'streak_event.dart';
part 'streak_state.dart';

class StreakBloc extends Bloc<StreakEvent, StreakState> {
  final CreateStreakUseCase createStreakUseCase;
  final GetStreaksUseCase getStreaksUseCase;
  final ViewStreakUseCase viewStreakUseCase;
  final SaveStreakUseCase saveStreakUseCase;
  final ReactToStreakUseCase reactToStreakUseCase;

  StreakBloc({
    required this.createStreakUseCase,
    required this.getStreaksUseCase,
    required this.viewStreakUseCase,
    required this.saveStreakUseCase,
    required this.reactToStreakUseCase,
  }) : super(StreakInitial()) {
    on<LoadStreaks>(_onLoadStreaks);
    on<CreateStreak>(_onCreateStreak);
    on<ViewStreak>(_onViewStreak);
    on<SaveStreak>(_onSaveStreak);
    on<ReactToStreak>(_onReactToStreak);
    on<UpdateStreakSettings>(_onUpdateStreakSettings);
    on<DeleteStreak>(_onDeleteStreak);
  }

  Future<void> _onLoadStreaks(
    LoadStreaks event,
    Emitter<StreakState> emit,
  ) async {
    emit(StreakLoading());
    
    try {
      final result = await getStreaksUseCase(event.chatId);
      
      result.fold(
        (failure) => emit(StreakFailure(failure.message)),
        (streaks) => emit(StreaksLoaded(streaks)),
      );
    } catch (e) {
      emit(StreakFailure(e.toString()));
    }
  }

  Future<void> _onCreateStreak(
    CreateStreak event,
    Emitter<StreakState> emit,
  ) async {
    try {
      final result = await createStreakUseCase(event.streak);
      
      result.fold(
        (failure) => emit(StreakFailure(failure.message)),
        (createdStreak) {
          if (state is StreaksLoaded) {
            final currentState = state as StreaksLoaded;
            final updatedStreaks = [createdStreak, ...currentState.streaks];
            emit(currentState.copyWith(streaks: updatedStreaks));
          }
        },
      );
    } catch (e) {
      emit(StreakFailure(e.toString()));
    }
  }

  Future<void> _onViewStreak(
    ViewStreak event,
    Emitter<StreakState> emit,
  ) async {
    try {
      final result = await viewStreakUseCase(event.streakId);
      
      result.fold(
        (failure) => emit(StreakFailure(failure.message)),
        (viewedStreak) {
          if (state is StreaksLoaded) {
            final currentState = state as StreaksLoaded;
            final updatedStreaks = currentState.streaks.map((streak) {
              if (streak.id == event.streakId) {
                return viewedStreak;
              }
              return streak;
            }).toList();
            emit(currentState.copyWith(streaks: updatedStreaks));
          }
        },
      );
    } catch (e) {
      emit(StreakFailure(e.toString()));
    }
  }

  Future<void> _onSaveStreak(
    SaveStreak event,
    Emitter<StreakState> emit,
  ) async {
    try {
      final result = await saveStreakUseCase(event.streakId);
      
      result.fold(
        (failure) => emit(StreakFailure(failure.message)),
        (_) {
          if (state is StreaksLoaded) {
            final currentState = state as StreaksLoaded;
            final updatedStreaks = currentState.streaks.map((streak) {
              if (streak.id == event.streakId) {
                return streak.copyWith(status: StreakStatus.saved);
              }
              return streak;
            }).toList();
            emit(currentState.copyWith(streaks: updatedStreaks));
          }
        },
      );
    } catch (e) {
      emit(StreakFailure(e.toString()));
    }
  }

  Future<void> _onReactToStreak(
    ReactToStreak event,
    Emitter<StreakState> emit,
  ) async {
    try {
      final result = await reactToStreakUseCase(event.streakId, event.emoji);
      
      result.fold(
        (failure) => emit(StreakFailure(failure.message)),
        (_) {
          if (state is StreaksLoaded) {
            final currentState = state as StreaksLoaded;
            final updatedStreaks = currentState.streaks.map((streak) {
              if (streak.id == event.streakId) {
                final newReaction = StreakReaction(
                  emoji: event.emoji,
                  userId: 'current_user_id', // TODO: Get current user ID
                  timestamp: DateTime.now(),
                );
                final updatedReactions = [...streak.reactions, newReaction];
                return streak.copyWith(reactions: updatedReactions);
              }
              return streak;
            }).toList();
            emit(currentState.copyWith(streaks: updatedStreaks));
          }
        },
      );
    } catch (e) {
      emit(StreakFailure(e.toString()));
    }
  }

  Future<void> _onUpdateStreakSettings(
    UpdateStreakSettings event,
    Emitter<StreakState> emit,
  ) async {
    try {
      // TODO: Implement update streak settings
      if (state is StreaksLoaded) {
        final currentState = state as StreaksLoaded;
        final updatedStreaks = currentState.streaks.map((streak) {
          if (streak.id == event.streakId) {
            return streak.copyWith(settings: event.settings);
          }
          return streak;
        }).toList();
        emit(currentState.copyWith(streaks: updatedStreaks));
      }
    } catch (e) {
      emit(StreakFailure(e.toString()));
    }
  }

  Future<void> _onDeleteStreak(
    DeleteStreak event,
    Emitter<StreakState> emit,
  ) async {
    try {
      // TODO: Implement delete streak
      if (state is StreaksLoaded) {
        final currentState = state as StreaksLoaded;
        final updatedStreaks = currentState.streaks
            .where((streak) => streak.id != event.streakId)
            .toList();
        emit(currentState.copyWith(streaks: updatedStreaks));
      }
    } catch (e) {
      emit(StreakFailure(e.toString()));
    }
  }
}
