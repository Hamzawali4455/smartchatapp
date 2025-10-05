import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/bloc/auth_bloc.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, AuthEntity>> call(RegisterCredentials credentials) async {
    try {
      // Validate credentials
      if (credentials.firstName.isEmpty || credentials.email.isEmpty || credentials.password.isEmpty) {
        return Left(ValidationFailure('First name, email and password are required'));
      }

      if (credentials.password != credentials.confirmPassword) {
        return Left(ValidationFailure('Passwords do not match'));
      }

      // Call repository to register
      final result = await repository.register(credentials);
      
      return result.fold(
        (failure) => Left(failure),
        (authEntity) => Right(authEntity),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
