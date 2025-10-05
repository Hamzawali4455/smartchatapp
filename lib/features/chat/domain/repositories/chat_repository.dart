import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../chat/domain/entities/chat_entity.dart';
import '../../../chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatEntity>>> getChats();
  Future<Either<Failure, List<MessageEntity>>> getMessages(String chatId);
  Future<Either<Failure, MessageEntity>> sendMessage(MessageEntity message);
  Future<Either<Failure, ChatEntity>> createChat(List<String> participants);
  Future<Either<Failure, ChatEntity>> updateChat(ChatEntity chat);
  Future<Either<Failure, void>> deleteChat(String chatId);
  Future<Either<Failure, List<MessageEntity>>> searchMessages(String query);
  Future<Either<Failure, void>> markAsRead(String chatId, String messageId);
  Future<Either<Failure, void>> addReaction(String messageId, String emoji, String userId);
  Future<Either<Failure, void>> removeReaction(String messageId, String emoji, String userId);
}
