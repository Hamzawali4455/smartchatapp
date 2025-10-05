import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/streak_repository.dart';

class ReactToStreakUseCase {
  final StreakRepository repository;

  ReactToStreakUseCase({required this.repository});

  Future<Either<Failure, void>> call(String streakId, String emoji) async {
    try {
      if (streakId.isEmpty) {
        return const Left(ValidationFailure('Streak ID is required'));
      }

      if (emoji.isEmpty) {
        return const Left(ValidationFailure('Emoji is required'));
      }

      // Call repository to react to streak
      final result = await repository.reactToStreak(streakId, emoji);
      
      return result.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
