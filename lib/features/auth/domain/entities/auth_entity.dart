import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String userId;
  final String token;
  final String refreshToken;
  final DateTime expiresAt;
  final AuthType type;
  final bool isAuthenticated;
  final UserDeviceInfo deviceInfo;

  const AuthEntity({
    required this.userId,
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
    required this.type,
    required this.isAuthenticated,
    required this.deviceInfo,
  });

  @override
  List<Object> get props => [
        userId,
        token,
        refreshToken,
        expiresAt,
        type,
        isAuthenticated,
        deviceInfo,
      ];

  AuthEntity copyWith({
    String? userId,
    String? token,
    String? refreshToken,
    DateTime? expiresAt,
    AuthType? type,
    bool? isAuthenticated,
    UserDeviceInfo? deviceInfo,
  }) {
    return AuthEntity(
      userId: userId ?? this.userId,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      type: type ?? this.type,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      deviceInfo: deviceInfo ?? this.deviceInfo,
    );
  }
}

enum AuthType {
  email,
  phone,
  biometric,
  social,
}

class UserDeviceInfo extends Equatable {
  final String deviceId;
  final String deviceName;
  final String platform;
  final String version;
  final String buildNumber;
  final bool isTrusted;
  final DateTime lastSeen;
  final String? ipAddress;
  final String? location;

  const UserDeviceInfo({
    required this.deviceId,
    required this.deviceName,
    required this.platform,
    required this.version,
    required this.buildNumber,
    this.isTrusted = false,
    required this.lastSeen,
    this.ipAddress,
    this.location,
  });

  @override
  List<Object?> get props => [
        deviceId,
        deviceName,
        platform,
        version,
        buildNumber,
        isTrusted,
        lastSeen,
        ipAddress,
        location,
      ];
}

