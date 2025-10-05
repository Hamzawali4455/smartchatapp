import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/streak_entity.dart';
import '../../domain/repositories/streak_repository.dart';

class CreateStreakUseCase {
  final StreakRepository repository;

  CreateStreakUseCase({required this.repository});

  Future<Either<Failure, StreakEntity>> call(StreakEntity streak) async {
    try {
      if (streak.content.isEmpty) {
        return const Left(ValidationFailure('Streak content is required'));
      }

      if (streak.chatId.isEmpty) {
        return const Left(ValidationFailure('Chat ID is required'));
      }

      if (streak.creatorId.isEmpty) {
        return const Left(ValidationFailure('Creator ID is required'));
      }

      if (streak.participantId.isEmpty) {
        return const Left(ValidationFailure('Participant ID is required'));
      }

      // Call repository to create streak
      final result = await repository.createStreak(streak);
      
      return result.fold(
        (failure) => Left(failure),
        (createdStreak) => Right(createdStreak),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
