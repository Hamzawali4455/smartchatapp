part of 'streak_bloc.dart';

abstract class StreakEvent extends Equatable {
  const StreakEvent();

  @override
  List<Object?> get props => [];
}

class LoadStreaks extends StreakEvent {
  final String chatId;

  const LoadStreaks({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

class CreateStreak extends StreakEvent {
  final StreakEntity streak;

  const CreateStreak({required this.streak});

  @override
  List<Object> get props => [streak];
}

class ViewStreak extends StreakEvent {
  final String streakId;

  const ViewStreak({required this.streakId});

  @override
  List<Object> get props => [streakId];
}

class SaveStreak extends StreakEvent {
  final String streakId;

  const SaveStreak({required this.streakId});

  @override
  List<Object> get props => [streakId];
}

class ReactToStreak extends StreakEvent {
  final String streakId;
  final String emoji;

  const ReactToStreak({
    required this.streakId,
    required this.emoji,
  });

  @override
  List<Object> get props => [streakId, emoji];
}

class UpdateStreakSettings extends StreakEvent {
  final String streakId;
  final StreakSettings settings;

  const UpdateStreakSettings({
    required this.streakId,
    required this.settings,
  });

  @override
  List<Object> get props => [streakId, settings];
}

class DeleteStreak extends StreakEvent {
  final String streakId;

  const DeleteStreak({required this.streakId});

  @override
  List<Object> get props => [streakId];
}
