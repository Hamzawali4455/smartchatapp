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
  final bool encrypted;
  final String algorithm;
  final String keyId;
  final bool doubleEncrypted;
  final DateTime? selfDestructAt;
  final bool screenshotProtected;
  final bool screenRecordProtected;

  const MessageEncryption({
    this.encrypted = true,
    this.algorithm = 'AES-256-GCM',
    required this.keyId,
    this.doubleEncrypted = false,
    this.selfDestructAt,
    this.screenshotProtected = false,
    this.screenRecordProtected = false,
  });

  @override
  List<Object?> get props => [
        encrypted,
        algorithm,
        keyId,
        doubleEncrypted,
        selfDestructAt,
        screenshotProtected,
        screenRecordProtected,
      ];
}

class MessageMetadata extends Equatable {
  final String? originalContent;
  final Map<String, dynamic>? customData;
  final List<String>? mentions;
  final List<String>? hashtags;
  final String? language;
  final double? sentimentScore;
  final Map<String, dynamic>? aiInsights;

  const MessageMetadata({
    this.originalContent,
    this.customData,
    this.mentions,
    this.hashtags,
    this.language,
    this.sentimentScore,
    this.aiInsights,
  });

  @override
  List<Object?> get props => [
        originalContent,
        customData,
        mentions,
        hashtags,
        language,
        sentimentScore,
        aiInsights,
      ];
}

class MessageAttachment extends Equatable {
  final String id;
  final String fileName;
  final String filePath;
  final String mimeType;
  final int fileSize;
  final String? thumbnailPath;
  final Map<String, dynamic>? metadata;
  final bool isEncrypted;
  final String? encryptionKey;
  final DateTime uploadedAt;

  const MessageAttachment({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.mimeType,
    required this.fileSize,
    this.thumbnailPath,
    this.metadata,
    this.isEncrypted = true,
    this.encryptionKey,
    required this.uploadedAt,
  });

  @override
  List<Object?> get props => [
        id,
        fileName,
        filePath,
        mimeType,
        fileSize,
        thumbnailPath,
        metadata,
        isEncrypted,
        encryptionKey,
        uploadedAt,
      ];
}
