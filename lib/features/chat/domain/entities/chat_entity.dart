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
}

class ChatSettings extends Equatable {
  final bool allowInvites;
  final bool allowMedia;
  final bool allowPolls;
  final bool encryptionEnabled;
  final bool muteNotifications;

  const ChatSettings({
    this.allowInvites = true,
    this.allowMedia = true,
    this.allowPolls = true,
    this.encryptionEnabled = false,
    this.muteNotifications = false,
  });

  @override
  List<Object> get props => [allowInvites, allowMedia, allowPolls, encryptionEnabled, muteNotifications];
}

class ChatEncryption extends Equatable {
  final String algorithm;
  final String keyId;
  final bool isEnabled;

  const ChatEncryption({
    required this.algorithm,
    required this.keyId,
    this.isEnabled = false,
  });

  @override
  List<Object> get props => [algorithm, keyId, isEnabled];
}
