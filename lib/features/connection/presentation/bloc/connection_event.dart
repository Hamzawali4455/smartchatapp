part of 'connection_bloc.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object?> get props => [];
}

class LoadConnectionHub extends ConnectionEvent {
  const LoadConnectionHub();
}

class StartBreathingExercise extends ConnectionEvent {
  final String participantId;
  final int duration;
  final BreathingPattern pattern;

  const StartBreathingExercise({
    required this.participantId,
    required this.duration,
    required this.pattern,
  });

  @override
  List<Object> get props => [participantId, duration, pattern];
}

class StartMoodMusic extends ConnectionEvent {
  final String participantId;
  final String mood;
  final List<String> playlist;

  const StartMoodMusic({
    required this.participantId,
    required this.mood,
    required this.playlist,
  });

  @override
  List<Object> get props => [participantId, mood, playlist];
}

class JoinSharedRoom extends ConnectionEvent {
  final String roomId;
  final List<String> participants;
  final String environment;

  const JoinSharedRoom({
    required this.roomId,
    required this.participants,
    required this.environment,
  });

  @override
  List<Object> get props => [roomId, participants, environment];
}

class UpdateRelationshipJournal extends ConnectionEvent {
  final String entry;
  final String participantId;

  const UpdateRelationshipJournal({
    required this.entry,
    required this.participantId,
  });

  @override
  List<Object> get props => [entry, participantId];
}

class StartDoodleSession extends ConnectionEvent {
  final String sessionId;
  final List<String> participants;

  const StartDoodleSession({
    required this.sessionId,
    required this.participants,
  });

  @override
  List<Object> get props => [sessionId, participants];
}

class PlayMoodRoulette extends ConnectionEvent {
  final List<String> participants;

  const PlayMoodRoulette({required this.participants});

  @override
  List<Object> get props => [participants];
}

class SendHeartbeat extends ConnectionEvent {
  final String fromUserId;
  final String toUserId;
  final double intensity;

  const SendHeartbeat({
    required this.fromUserId,
    required this.toUserId,
    required this.intensity,
  });

  @override
  List<Object> get props => [fromUserId, toUserId, intensity];
}

class SendSilentHug extends ConnectionEvent {
  final String fromUserId;
  final String toUserId;
  final int duration;

  const SendSilentHug({
    required this.fromUserId,
    required this.toUserId,
    required this.duration,
  });

  @override
  List<Object> get props => [fromUserId, toUserId, duration];
}

class TriggerMemory extends ConnectionEvent {
  final String memoryId;
  final List<String> participants;
  final String memory;

  const TriggerMemory({
    required this.memoryId,
    required this.participants,
    required this.memory,
  });

  @override
  List<Object> get props => [memoryId, participants, memory];
}

enum BreathingPattern {
  box,
  triangle,
  circle,
  wave,
}
