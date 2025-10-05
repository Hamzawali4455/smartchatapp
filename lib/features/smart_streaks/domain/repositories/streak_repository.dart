import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/streak_entity.dart';

abstract class StreakRepository {
  Future<Either<Failure, List<StreakEntity>>> getStreaks(String chatId);
  Future<Either<Failure, StreakEntity>> createStreak(StreakEntity streak);
  Future<Either<Failure, StreakEntity>> viewStreak(String streakId);
  Future<Either<Failure, void>> saveStreak(String streakId);
  Future<Either<Failure, void>> reactToStreak(String streakId, String emoji);
  Future<Either<Failure, StreakEntity>> updateStreak(StreakEntity streak);
  Future<Either<Failure, void>> deleteStreak(String streakId);
  Future<Either<Failure, void>> updateStreakSettings(String streakId, StreakSettings settings);
  Future<Either<Failure, List<StreakEntity>>> getStreakHistory(String chatId);
  Future<Either<Failure, void>> reportStreak(String streakId, String reason);
}
