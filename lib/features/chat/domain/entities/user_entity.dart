import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? avatar;
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isOnline;
  final DateTime? lastSeen;
  final UserSettings settings;
  final UserPreferences preferences;

  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.avatar,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
    this.isOnline = false,
    this.lastSeen,
    required this.settings,
    required this.preferences,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        phoneNumber,
        avatar,
        bio,
        createdAt,
        updatedAt,
        isOnline,
        lastSeen,
        settings,
        preferences,
      ];

  UserEntity copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? avatar,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isOnline,
    DateTime? lastSeen,
    UserSettings? settings,
    UserPreferences? preferences,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      settings: settings ?? this.settings,
      preferences: preferences ?? this.preferences,
    );
  }
}

class UserSettings extends Equatable {
  final bool allowNotifications;
  final bool allowLocationSharing;
  final bool allowReadReceipts;
  final bool allowTypingIndicators;
  final bool allowOnlineStatus;
  final bool allowLastSeen;

  const UserSettings({
    this.allowNotifications = true,
    this.allowLocationSharing = false,
    this.allowReadReceipts = true,
    this.allowTypingIndicators = true,
    this.allowOnlineStatus = true,
    this.allowLastSeen = true,
  });

  @override
  List<Object> get props => [
        allowNotifications,
        allowLocationSharing,
        allowReadReceipts,
        allowTypingIndicators,
        allowOnlineStatus,
        allowLastSeen,
      ];
}

class UserPreferences extends Equatable {
  final String theme;
  final String language;
  final String fontSize;
  final bool darkMode;

  const UserPreferences({
    this.theme = 'system',
    this.language = 'en',
    this.fontSize = 'medium',
    this.darkMode = false,
  });

  @override
  List<Object> get props => [theme, language, fontSize, darkMode];
}
