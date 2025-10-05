import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../chat/domain/entities/message_entity.dart';
import '../../../chat/domain/repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase({required this.repository});

  Future<Either<Failure, List<MessageEntity>>> call(String chatId) async {
    try {
      if (chatId.isEmpty) {
        return const Left(ValidationFailure('Chat ID is required'));
      }

      // Call repository to get messages
      final result = await repository.getMessages(chatId);
      
      return result.fold(
        (failure) => Left(failure),
        (messages) => Right(messages),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
