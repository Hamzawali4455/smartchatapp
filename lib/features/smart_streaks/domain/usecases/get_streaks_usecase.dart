import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/streak_entity.dart';
import '../../domain/repositories/streak_repository.dart';

class GetStreaksUseCase {
  final StreakRepository repository;

  GetStreaksUseCase({required this.repository});

  Future<Either<Failure, List<StreakEntity>>> call(String chatId) async {
    try {
      if (chatId.isEmpty) {
        return const Left(ValidationFailure('Chat ID is required'));
      }

      // Call repository to get streaks
      final result = await repository.getStreaks(chatId);
      
      return result.fold(
        (failure) => Left(failure),
        (streaks) => Right(streaks),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
