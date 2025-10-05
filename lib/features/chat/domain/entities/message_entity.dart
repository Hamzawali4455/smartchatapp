import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final MessageType type;
  final MessageStatus status;
  final DateTime timestamp;
  final DateTime? editedAt;
  final String? replyToMessageId;
  final List<String> forwardedFrom;
  final List<MessageReaction> reactions;
  final MessageEncryption encryption;
  final MessageMetadata metadata;
  final List<MessageAttachment> attachments;
  final bool isEdited;
  final bool isDeleted;
  final DateTime? deletedAt;
  final String? deleteReason;

  const MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.type,
    required this.status,
    required this.timestamp,
    this.editedAt,
    this.replyToMessageId,
    this.forwardedFrom = const [],
    this.reactions = const [],
    required this.encryption,
    required this.metadata,
    this.attachments = const [],
    this.isEdited = false,
    this.isDeleted = false,
    this.deletedAt,
    this.deleteReason,
  });

  @override
  List<Object?> get props => [
        id,
        chatId,
        senderId,
        content,
        type,
        status,
        timestamp,
        editedAt,
        replyToMessageId,
        forwardedFrom,
        reactions,
        encryption,
        metadata,
        attachments,
        isEdited,
        isDeleted,
        deletedAt,
        deleteReason,
      ];

  MessageEntity copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? content,
    MessageType? type,
    MessageStatus? status,
    DateTime? timestamp,
    DateTime? editedAt,
    String? replyToMessageId,
    List<String>? forwardedFrom,
    List<MessageReaction>? reactions,
    MessageEncryption? encryption,
    MessageMetadata? metadata,
    List<MessageAttachment>? attachments,
    bool? isEdited,
    bool? isDeleted,
    DateTime? deletedAt,
    String? deleteReason,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      editedAt: editedAt ?? this.editedAt,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      forwardedFrom: forwardedFrom ?? this.forwardedFrom,
      reactions: reactions ?? this.reactions,
      encryption: encryption ?? this.encryption,
      metadata: metadata ?? this.metadata,
      attachments: attachments ?? this.attachments,
      isEdited: isEdited ?? this.isEdited,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      deleteReason: deleteReason ?? this.deleteReason,
    );
  }
}

enum MessageType {
  text,
  image,
  video,
  audio,
  document,
  sticker,
  gif,
  voice,
  videoCall,
  audioCall,
  location,
  contact,
  poll,
  reaction,
  system,
  encrypted,
  selfDestruct,
  streak,
}

enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
  deleted,
}

class MessageReaction extends Equatable {
  final String emoji;
  final String userId;
  final DateTime timestamp;

  const MessageReaction({
    required this.emoji,
    required this.userId,
    required this.timestamp,
  });

  @override
  List<Object> get props => [emoji, userId, timestamp];
}

class MessageEncryption extends Equatable {
  final String algorithm;
  final String keyId;
  final String iv;

  const MessageEncryption({
    required this.algorithm,
    required this.keyId,
    required this.iv,
  });

  @override
  List<Object> get props => [algorithm, keyId, iv];
}

class MessageMetadata extends Equatable {
  final List<String> readBy;
  final List<String> deliveredTo;
  final bool screenshotDetected;
  final bool screenRecordDetected;

  const MessageMetadata({
    this.readBy = const [],
    this.deliveredTo = const [],
    this.screenshotDetected = false,
    this.screenRecordDetected = false,
  });

  @override
  List<Object> get props => [readBy, deliveredTo, screenshotDetected, screenRecordDetected];
}

class MessageAttachment extends Equatable {
  final String type;
  final String url;
  final String filename;
  final int size;
  final String? thumbnail;

  const MessageAttachment({
    required this.type,
    required this.url,
    required this.filename,
    required this.size,
    this.thumbnail,
  });

  @override
  List<Object?> get props => [type, url, filename, size, thumbnail];
}
