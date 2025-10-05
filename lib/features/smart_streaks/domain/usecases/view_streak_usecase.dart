import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/streak_entity.dart';
import '../../domain/repositories/streak_repository.dart';

class ViewStreakUseCase {
  final StreakRepository repository;

  ViewStreakUseCase({required this.repository});

  Future<Either<Failure, StreakEntity>> call(String streakId) async {
    try {
      if (streakId.isEmpty) {
        return const Left(ValidationFailure('Streak ID is required'));
      }

      // Call repository to view streak
      final result = await repository.viewStreak(streakId);
      
      return result.fold(
        (failure) => Left(failure),
        (streak) => Right(streak),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
