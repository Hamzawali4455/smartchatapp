part of 'connection_bloc.dart';

abstract class ConnectionState extends Equatable {
  const ConnectionState();

  @override
  List<Object?> get props => [];
}

class ConnectionInitial extends ConnectionState {}

class ConnectionLoading extends ConnectionState {}

class ConnectionHubLoaded extends ConnectionState {}

class BreathingExerciseActive extends ConnectionState {
  final String participantId;
  final int duration;
  final BreathingPattern pattern;

  const BreathingExerciseActive({
    required this.participantId,
    required this.duration,
    required this.pattern,
  });

  @override
  List<Object> get props => [participantId, duration, pattern];
}

class MoodMusicActive extends ConnectionState {
  final String participantId;
  final String mood;
  final List<String> playlist;

  const MoodMusicActive({
    required this.participantId,
    required this.mood,
    required this.playlist,
  });

  @override
  List<Object> get props => [participantId, mood, playlist];
}

class SharedRoomActive extends ConnectionState {
  final String roomId;
  final List<String> participants;
  final String environment;

  const SharedRoomActive({
    required this.roomId,
    required this.participants,
    required this.environment,
  });

  @override
  List<Object> get props => [roomId, participants, environment];
}

class JournalUpdated extends ConnectionState {
  final String entry;
  final String participantId;

  const JournalUpdated({
    required this.entry,
    required this.participantId,
  });

  @override
  List<Object> get props => [entry, participantId];
}

class DoodleSessionActive extends ConnectionState {
  final String sessionId;
  final List<String> participants;

  const DoodleSessionActive({
    required this.sessionId,
    required this.participants,
  });

  @override
  List<Object> get props => [sessionId, participants];
}

class MoodRouletteResult extends ConnectionState {
  final List<String> participants;
  final String selectedMood;

  const MoodRouletteResult({
    required this.participants,
    required this.selectedMood,
  });

  @override
  List<Object> get props => [participants, selectedMood];
}

class HeartbeatSent extends ConnectionState {
  final String fromUserId;
  final String toUserId;
  final double intensity;

  const HeartbeatSent({
    required this.fromUserId,
    required this.toUserId,
    required this.intensity,
  });

  @override
  List<Object> get props => [fromUserId, toUserId, intensity];
}

class SilentHugSent extends ConnectionState {
  final String fromUserId;
  final String toUserId;
  final int duration;

  const SilentHugSent({
    required this.fromUserId,
    required this.toUserId,
    required this.duration,
  });

  @override
  List<Object> get props => [fromUserId, toUserId, duration];
}

class MemoryTriggered extends ConnectionState {
  final String memoryId;
  final List<String> participants;
  final String memory;

  const MemoryTriggered({
    required this.memoryId,
    required this.participants,
    required this.memory,
  });

  @override
  List<Object> get props => [memoryId, participants, memory];
}

class ConnectionFailure extends ConnectionState {
  final String message;

  const ConnectionFailure(this.message);

  @override
  List<Object> get props => [message];
}
