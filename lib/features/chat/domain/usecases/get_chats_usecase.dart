import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../chat/domain/entities/chat_entity.dart';
import '../../../chat/domain/repositories/chat_repository.dart';

class GetChatsUseCase {
  final ChatRepository repository;

  GetChatsUseCase({required this.repository});

  Future<Either<Failure, List<ChatEntity>>> call() async {
    try {
      // Call repository to get chats
      final result = await repository.getChats();
      
      return result.fold(
        (failure) => Left(failure),
        (chats) => Right(chats),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
