import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';

class ConvexChatRepository implements ChatRepository {
  @override
  Future<Either<Failure, List<ChatEntity>>> getChats() async {
    // TODO: Implement with Convex
    return const Right([]);
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages(String chatId) async {
    // TODO: Implement with Convex
    return const Right([]);
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage(MessageEntity message) async {
    // TODO: Implement with Convex
    return Right(message);
  }

  @override
  Future<Either<Failure, ChatEntity>> createChat(List<String> participants) async {
    // TODO: Implement with Convex
    final chat = ChatEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'New Chat',
      type: ChatType.direct,
      participants: participants,
      settings: const ChatSettings(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      encryption: const ChatEncryption(algorithm: 'AES', keyId: 'default'),
    );
    return Right(chat);
  }

  @override
  Future<Either<Failure, ChatEntity>> updateChat(ChatEntity chat) async {
    // TODO: Implement with Convex
    return Right(chat);
  }

  @override
  Future<Either<Failure, void>> deleteChat(String chatId) async {
    // TODO: Implement with Convex
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> searchMessages(String query) async {
    // TODO: Implement with Convex
    return const Right([]);
  }

  @override
  Future<Either<Failure, void>> markAsRead(String chatId, String messageId) async {
    // TODO: Implement with Convex
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> addReaction(String messageId, String emoji, String userId) async {
    // TODO: Implement with Convex
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> removeReaction(String messageId, String emoji, String userId) async {
    // TODO: Implement with Convex
    return const Right(null);
  }
}
