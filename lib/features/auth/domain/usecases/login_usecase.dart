import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/bloc/auth_bloc.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, AuthEntity>> call(LoginCredentials credentials) async {
    try {
      // Validate credentials
      if (credentials.email.isEmpty || credentials.password.isEmpty) {
        return Left(ValidationFailure('Email and password are required'));
      }

      // Call repository to authenticate
      final result = await repository.login(credentials);
      
      return result.fold(
        (failure) => Left(failure),
        (authEntity) => Right(authEntity),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
