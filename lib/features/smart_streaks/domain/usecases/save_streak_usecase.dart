import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/streak_repository.dart';

class SaveStreakUseCase {
  final StreakRepository repository;

  SaveStreakUseCase({required this.repository});

  Future<Either<Failure, void>> call(String streakId) async {
    try {
      if (streakId.isEmpty) {
        return const Left(ValidationFailure('Streak ID is required'));
      }

      // Call repository to save streak
      final result = await repository.saveStreak(streakId);
      
      return result.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
