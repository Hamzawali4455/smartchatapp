import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../chat/domain/entities/message_entity.dart';
import '../../../chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<Either<Failure, MessageEntity>> call(MessageEntity message) async {
    try {
      if (message.content.isEmpty && message.attachments.isEmpty) {
        return const Left(ValidationFailure('Message content or attachments are required'));
      }

      if (message.chatId.isEmpty) {
        return const Left(ValidationFailure('Chat ID is required'));
      }

      if (message.senderId.isEmpty) {
        return const Left(ValidationFailure('Sender ID is required'));
      }

      // Call repository to send message
      final result = await repository.sendMessage(message);
      
      return result.fold(
        (failure) => Left(failure),
        (sentMessage) => Right(sentMessage),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
