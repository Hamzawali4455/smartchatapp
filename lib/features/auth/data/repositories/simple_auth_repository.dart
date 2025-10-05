import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/bloc/auth_bloc.dart';

class SimpleAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, AuthEntity>> login(LoginCredentials credentials) async {
    try {
      // Simulate login delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock successful login
      final authEntity = AuthEntity(
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
        type: AuthType.email,
        isAuthenticated: true,
        deviceInfo: UserDeviceInfo(
          deviceId: 'mock_device_id',
          deviceName: 'Mock Device',
          platform: 'Web',
          version: '1.0.0',
          buildNumber: '1',
          lastSeen: DateTime.now(),
        ),
      );
      
      return Right(authEntity);
    } catch (e) {
      return Left(ServerFailure('Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> register(RegisterCredentials credentials) async {
    try {
      // Simulate registration delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock successful registration
      final authEntity = AuthEntity(
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
        type: AuthType.email,
        isAuthenticated: true,
        deviceInfo: UserDeviceInfo(
          deviceId: 'mock_device_id',
          deviceName: 'Mock Device',
          platform: 'Web',
          version: '1.0.0',
          buildNumber: '1',
          lastSeen: DateTime.now(),
        ),
      );
      
      return Right(authEntity);
    } catch (e) {
      return Left(ServerFailure('Registration failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Simulate logout delay
      await Future.delayed(const Duration(milliseconds: 500));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Logout failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken() async {
    try {
      // Simulate token refresh
      await Future.delayed(const Duration(milliseconds: 500));
      
      final authEntity = AuthEntity(
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
        token: 'refreshed_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'refreshed_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
        type: AuthType.email,
        isAuthenticated: true,
        deviceInfo: UserDeviceInfo(
          deviceId: 'mock_device_id',
          deviceName: 'Mock Device',
          platform: 'Web',
          version: '1.0.0',
          buildNumber: '1',
          lastSeen: DateTime.now(),
        ),
      );
      
      return Right(authEntity);
    } catch (e) {
      return Left(ServerFailure('Token refresh failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuthStatus() async {
    try {
      // Simulate auth check
      await Future.delayed(const Duration(milliseconds: 300));
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure('Auth check failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> biometricLogin() async {
    try {
      // Simulate biometric login
      await Future.delayed(const Duration(seconds: 1));
      
      final authEntity = AuthEntity(
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
        token: 'biometric_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'biometric_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
        type: AuthType.biometric,
        isAuthenticated: true,
        deviceInfo: UserDeviceInfo(
          deviceId: 'mock_device_id',
          deviceName: 'Mock Device',
          platform: 'Web',
          version: '1.0.0',
          buildNumber: '1',
          lastSeen: DateTime.now(),
        ),
      );
      
      return Right(authEntity);
    } catch (e) {
      return Left(ServerFailure('Biometric login failed: ${e.toString()}'));
    }
  }
}
