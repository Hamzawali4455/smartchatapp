import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/convex_service.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/bloc/auth_bloc.dart';

class ConvexAuthRepository implements AuthRepository {
  final ConvexService _convexService = ConvexService.instance;

  @override
  Future<Either<Failure, AuthEntity>> login(LoginCredentials credentials) async {
    try {
      // Call Convex login function
      final result = await _convexService.call<Map<String, dynamic>>(
        'users:getUserByEmail',
        {'email': credentials.email},
      );

      if (result == null) {
        return Left(ServerFailure('User not found'));
      }

      // Create AuthEntity from Convex result
      final authEntity = AuthEntity(
        userId: result['_id'],
        token: 'convex_token', // Convex handles auth internally
        refreshToken: 'convex_refresh_token',
        expiresAt: DateTime.now().add(const Duration(days: 30)),
        type: AuthType.email,
        isAuthenticated: true,
        deviceInfo: UserDeviceInfo(
          deviceId: 'device_id',
          deviceName: 'Flutter Device',
          platform: 'Flutter',
          version: '1.0.0',
          buildNumber: '1',
          isTrusted: true,
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
      // Call Convex create user function
      final result = await _convexService.mutation<Map<String, dynamic>>(
        'users:createUser',
        {
          'email': credentials.email,
          'username': credentials.username,
          'profilePicture': credentials.profilePicture,
          'bio': credentials.bio,
        },
      );

      // Create AuthEntity from Convex result
      final authEntity = AuthEntity(
        userId: result['_id'],
        token: 'convex_token',
        refreshToken: 'convex_refresh_token',
        expiresAt: DateTime.now().add(const Duration(days: 30)),
        type: AuthType.email,
        isAuthenticated: true,
        deviceInfo: UserDeviceInfo(
          deviceId: 'device_id',
          deviceName: 'Flutter Device',
          platform: 'Flutter',
          version: '1.0.0',
          buildNumber: '1',
          isTrusted: true,
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
      // Convex handles logout automatically
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Logout failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken() async {
    try {
      // Convex handles token refresh automatically
      return Left(ServerFailure('Token refresh not needed with Convex'));
    } catch (e) {
      return Left(ServerFailure('Token refresh failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuthStatus() async {
    try {
      // Check if Convex is initialized
      return Right(_convexService.isInitialized);
    } catch (e) {
      return Left(ServerFailure('Auth check failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> biometricLogin() async {
    try {
      // Implement biometric login with Convex
      return Left(ServerFailure('Biometric login not implemented yet'));
    } catch (e) {
      return Left(ServerFailure('Biometric login failed: ${e.toString()}'));
    }
  }
}
