part of 'streak_bloc.dart';

abstract class StreakState extends Equatable {
  const StreakState();

  @override
  List<Object?> get props => [];
}

class StreakInitial extends StreakState {}

class StreakLoading extends StreakState {}

class StreaksLoaded extends StreakState {
  final List<StreakEntity> streaks;

  const StreaksLoaded({required this.streaks});

  @override
  List<Object> get props => [streaks];

  StreaksLoaded copyWith({
    List<StreakEntity>? streaks,
  }) {
    return StreaksLoaded(
      streaks: streaks ?? this.streaks,
    );
  }
}

class StreakFailure extends StreakState {
  final String message;

  const StreakFailure(this.message);

  @override
  List<Object> get props => [message];
}
