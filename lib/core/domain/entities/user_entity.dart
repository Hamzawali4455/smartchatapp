import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? phoneNumber;
  final String? profilePicture;
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isOnline;
  final DateTime? lastSeen;
  final UserSettings settings;
  final UserSecurity security;

  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.profilePicture,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
    this.isOnline = false,
    this.lastSeen,
    required this.settings,
    required this.security,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        phoneNumber,
        profilePicture,
        bio,
        createdAt,
        updatedAt,
        isOnline,
        lastSeen,
        settings,
        security,
      ];

  UserEntity copyWith({
    String? id,
    String? username,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isOnline,
    DateTime? lastSeen,
    UserSettings? settings,
    UserSecurity? security,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      settings: settings ?? this.settings,
      security: security ?? this.security,
    );
  }
}

class UserSettings extends Equatable {
  final bool notificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final bool darkMode;
  final String language;
  final bool readReceipts;
  final bool typingIndicators;
  final bool showOnlineStatus;
  final bool allowCalls;
  final bool allowVideoCalls;

  const UserSettings({
    this.notificationsEnabled = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.darkMode = false,
    this.language = 'en',
    this.readReceipts = true,
    this.typingIndicators = true,
    this.showOnlineStatus = true,
    this.allowCalls = true,
    this.allowVideoCalls = true,
  });

  @override
  List<Object> get props => [
        notificationsEnabled,
        soundEnabled,
        vibrationEnabled,
        darkMode,
        language,
        readReceipts,
        typingIndicators,
        showOnlineStatus,
        allowCalls,
        allowVideoCalls,
      ];
}

class UserSecurity extends Equatable {
  final bool twoFactorEnabled;
  final bool biometricEnabled;
  final bool appLockEnabled;
  final bool stealthModeEnabled;
  final DateTime? lastPasswordChange;
  final List<String> trustedDevices;
  final EncryptionSettings encryption;

  const UserSecurity({
    this.twoFactorEnabled = false,
    this.biometricEnabled = false,
    this.appLockEnabled = false,
    this.stealthModeEnabled = false,
    this.lastPasswordChange,
    this.trustedDevices = const [],
    required this.encryption,
  });

  @override
  List<Object?> get props => [
        twoFactorEnabled,
        biometricEnabled,
        appLockEnabled,
        stealthModeEnabled,
        lastPasswordChange,
        trustedDevices,
        encryption,
      ];
}

class EncryptionSettings extends Equatable {
  final bool endToEndEncryption;
  final bool doubleEncryption;
  final String encryptionKey;
  final DateTime keyGeneratedAt;
  final int keyVersion;

  const EncryptionSettings({
    this.endToEndEncryption = true,
    this.doubleEncryption = false,
    required this.encryptionKey,
    required this.keyGeneratedAt,
    this.keyVersion = 1,
  });

  @override
  List<Object> get props => [
        endToEndEncryption,
        doubleEncryption,
        encryptionKey,
        keyGeneratedAt,
        keyVersion,
      ];
}
