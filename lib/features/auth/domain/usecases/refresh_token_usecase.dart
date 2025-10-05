import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase({required this.repository});

  Future<Either<Failure, AuthEntity>> call() async {
    try {
      return await repository.refreshToken();
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}