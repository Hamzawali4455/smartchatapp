part of 'auth_bloc.dart';

class LoginCredentials extends Equatable {
  final String email;
  final String password;
  final bool rememberMe;
  final bool biometricEnabled;

  const LoginCredentials({
    required this.email,
    required this.password,
    this.rememberMe = false,
    this.biometricEnabled = false,
  });

  @override
  List<Object> get props => [email, password, rememberMe, biometricEnabled];
}

class RegisterCredentials extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String? phoneNumber;

  const RegisterCredentials({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [email, password, confirmPassword, firstName, lastName, phoneNumber];
}

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final LoginCredentials credentials;

  const LoginRequested({required this.credentials});

  @override
  List<Object> get props => [credentials];
}

class RegisterRequested extends AuthEvent {
  final RegisterCredentials credentials;

  const RegisterRequested({required this.credentials});

  @override
  List<Object> get props => [credentials];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class RefreshTokenRequested extends AuthEvent {
  const RefreshTokenRequested();
}

class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

class BiometricLoginRequested extends AuthEvent {
  const BiometricLoginRequested();
}
