import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_entity.dart';
import '../../presentation/bloc/auth_bloc.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(LoginCredentials credentials);
  Future<Either<Failure, AuthEntity>> register(RegisterCredentials credentials);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, AuthEntity>> refreshToken();
  Future<Either<Failure, bool>> checkAuthStatus();
  Future<Either<Failure, AuthEntity>> biometricLogin();
}
