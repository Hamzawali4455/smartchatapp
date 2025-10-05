import 'package:equatable/equatable.dart';
import 'message_entity.dart';
import 'user_entity.dart';

class ChatEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final ChatType type;
  final String? avatar;
  final List<String> participants;
  final String? lastMessageId;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final ChatSettings settings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
  final bool isPinned;
  final ChatEncryption encryption;

  const ChatEntity({
    required this.id,
    required this.name,
    this.description,
    required this.type,
    this.avatar,
    required this.participants,
    this.lastMessageId,
    this.lastMessageAt,
    this.unreadCount = 0,
    required this.settings,
    required this.createdAt,
    required this.updatedAt,
    this.isArchived = false,
    this.isPinned = false,
    required this.encryption,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        type,
        avatar,
        participants,
        lastMessageId,
        lastMessageAt,
        unreadCount,
        settings,
        createdAt,
        updatedAt,
        isArchived,
        isPinned,
        encryption,
      ];

  ChatEntity copyWith({
    String? id,
    String? name,
    String? description,
    ChatType? type,
    String? avatar,
    List<String>? participants,
    String? lastMessageId,
    DateTime? lastMessageAt,
    int? unreadCount,
    ChatSettings? settings,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isArchived,
    bool? isPinned,
    ChatEncryption? encryption,
  }) {
    return ChatEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      avatar: avatar ?? this.avatar,
      participants: participants ?? this.participants,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      settings: settings ?? this.settings,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
      isPinned: isPinned ?? this.isPinned,
      encryption: encryption ?? this.encryption,
    );
  }
}

enum ChatType {
  direct,
  group,
  channel,
  broadcast,
}

class ChatSettings extends Equatable {
  final bool allowInvites;
  final bool allowMedia;
  final bool allowCalls;
  final bool allowVideoCalls;
  final bool allowScreenShare;
  final bool allowFileSharing;
  final bool allowVoiceMessages;
  final bool allowStickers;
  final bool allowGifs;
  final bool allowPolls;
  final bool allowReactions;
  final bool allowEditing;
  final bool allowDeleting;
  final bool allowForwarding;
  final bool allowCopying;
  final bool allowScreenshot;
  final bool allowScreenRecord;
  final int messageRetentionDays;
  final bool autoDelete;
  final bool muteNotifications;
  final bool archiveAfterInactivity;

  const ChatSettings({
    this.allowInvites = true,
    this.allowMedia = true,
    this.allowCalls = true,
    this.allowVideoCalls = true,
    this.allowScreenShare = true,
    this.allowFileSharing = true,
    this.allowVoiceMessages = true,
    this.allowStickers = true,
    this.allowGifs = true,
    this.allowPolls = true,
    this.allowReactions = true,
    this.allowEditing = true,
    this.allowDeleting = true,
    this.allowForwarding = true,
    this.allowCopying = true,
    this.allowScreenshot = true,
    this.allowScreenRecord = true,
    this.messageRetentionDays = 30,
    this.autoDelete = false,
    this.muteNotifications = false,
    this.archiveAfterInactivity = false,
  });

  @override
  List<Object> get props => [
        allowInvites,
        allowMedia,
        allowCalls,
        allowVideoCalls,
        allowScreenShare,
        allowFileSharing,
        allowVoiceMessages,
        allowStickers,
        allowGifs,
        allowPolls,
        allowReactions,
        allowEditing,
        allowDeleting,
        allowForwarding,
        allowCopying,
        allowScreenshot,
        allowScreenRecord,
        messageRetentionDays,
        autoDelete,
        muteNotifications,
        archiveAfterInactivity,
      ];
}

class ChatEncryption extends Equatable {
  final bool enabled;
  final String algorithm;
  final String keyId;
  final DateTime keyGeneratedAt;
  final bool forwardSecrecy;
  final bool perfectForwardSecrecy;

  const ChatEncryption({
    this.enabled = true,
    this.algorithm = 'AES-256-GCM',
    required this.keyId,
    required this.keyGeneratedAt,
    this.forwardSecrecy = true,
    this.perfectForwardSecrecy = false,
  });

  @override
  List<Object> get props => [
        enabled,
        algorithm,
        keyId,
        keyGeneratedAt,
        forwardSecrecy,
        perfectForwardSecrecy,
      ];
}
