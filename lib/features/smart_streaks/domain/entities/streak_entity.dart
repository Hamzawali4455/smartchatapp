import 'package:equatable/equatable.dart';

class StreakEntity extends Equatable {
  final String id;
  final String chatId;
  final String creatorId;
  final String participantId;
  final StreakType type;
  final String content;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final StreakStatus status;
  final StreakSettings settings;
  final List<StreakReaction> reactions;
  final StreakEncryption encryption;

  const StreakEntity({
    required this.id,
    required this.chatId,
    required this.creatorId,
    required this.participantId,
    required this.type,
    required this.content,
    required this.createdAt,
    this.expiresAt,
    required this.status,
    required this.settings,
    this.reactions = const [],
    required this.encryption,
  });

  @override
  List<Object?> get props => [
        id,
        chatId,
        creatorId,
        participantId,
        type,
        content,
        createdAt,
        expiresAt,
        status,
        settings,
        reactions,
        encryption,
      ];

  StreakEntity copyWith({
    String? id,
    String? chatId,
    String? creatorId,
    String? participantId,
    StreakType? type,
    String? content,
    DateTime? createdAt,
    DateTime? expiresAt,
    StreakStatus? status,
    StreakSettings? settings,
    List<StreakReaction>? reactions,
    StreakEncryption? encryption,
  }) {
    return StreakEntity(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      creatorId: creatorId ?? this.creatorId,
      participantId: participantId ?? this.participantId,
      type: type ?? this.type,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      status: status ?? this.status,
      settings: settings ?? this.settings,
      reactions: reactions ?? this.reactions,
      encryption: encryption ?? this.encryption,
    );
  }
}

enum StreakType {
  image,
  video,
  audio,
  text,
  drawing,
  poll,
  memory,
  mood,
}

enum StreakStatus {
  active,
  viewed,
  saved,
  expired,
  deleted,
}

class StreakSettings extends Equatable {
  final bool allowSave;
  final bool allowViewOnly;
  final bool timedSave;
  final bool encryptedSave;
  final bool screenshotAlert;
  final bool screenRecordAlert;
  final bool streakLock;
  final String? lockPassword;
  final bool biometricLock;
  final bool allowEditing;
  final bool allowCollaboration;
  final bool allowPolls;
  final bool allowReactions;
  final int maxViews;
  final int currentViews;

  const StreakSettings({
    this.allowSave = true,
    this.allowViewOnly = false,
    this.timedSave = false,
    this.encryptedSave = false,
    this.screenshotAlert = false,
    this.screenRecordAlert = false,
    this.streakLock = false,
    this.lockPassword,
    this.biometricLock = false,
    this.allowEditing = false,
    this.allowCollaboration = false,
    this.allowPolls = false,
    this.allowReactions = true,
    this.maxViews = 1,
    this.currentViews = 0,
  });

  @override
  List<Object?> get props => [
        allowSave,
        allowViewOnly,
        timedSave,
        encryptedSave,
        screenshotAlert,
        screenRecordAlert,
        streakLock,
        lockPassword,
        biometricLock,
        allowEditing,
        allowCollaboration,
        allowPolls,
        allowReactions,
        maxViews,
        currentViews,
      ];
}

class StreakReaction extends Equatable {
  final String emoji;
  final String userId;
  final DateTime timestamp;

  const StreakReaction({
    required this.emoji,
    required this.userId,
    required this.timestamp,
  });

  @override
  List<Object> get props => [emoji, userId, timestamp];
}

class StreakEncryption extends Equatable {
  final bool enabled;
  final String algorithm;
  final String keyId;
  final DateTime keyGeneratedAt;
  final bool selfDestruct;
  final DateTime? selfDestructAt;

  const StreakEncryption({
    this.enabled = true,
    this.algorithm = 'AES-256-GCM',
    required this.keyId,
    required this.keyGeneratedAt,
    this.selfDestruct = false,
    this.selfDestructAt,
  });

  @override
  List<Object?> get props => [
        enabled,
        algorithm,
        keyId,
        keyGeneratedAt,
        selfDestruct,
        selfDestructAt,
      ];
}
