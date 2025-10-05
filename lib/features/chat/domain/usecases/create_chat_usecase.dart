import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../chat/domain/entities/chat_entity.dart';
import '../../../chat/domain/repositories/chat_repository.dart';

class CreateChatUseCase {
  final ChatRepository repository;

  CreateChatUseCase({required this.repository});

  Future<Either<Failure, ChatEntity>> call(List<String> participants) async {
    try {
      if (participants.isEmpty) {
        return const Left(ValidationFailure('At least one participant is required'));
      }

      if (participants.length < 2) {
        return const Left(ValidationFailure('At least two participants are required for a chat'));
      }

      // Call repository to create chat
      final result = await repository.createChat(participants);
      
      return result.fold(
        (failure) => Left(failure),
        (chat) => Right(chat),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
