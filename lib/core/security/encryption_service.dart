import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  factory EncryptionService() => _instance;
  EncryptionService._internal();

  late Encrypter _encrypter;
  late Key _key;
  late IV _iv;

  void initialize(String masterKey) {
    // Generate key from master key
    final keyBytes = sha256.convert(utf8.encode(masterKey)).bytes;
    _key = Key(keyBytes);
    _encrypter = Encrypter(AES(_key));
  }

  String generateKey() {
    final random = Random.secure();
    final keyBytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Encode(keyBytes);
  }

  String encryptMessage(String message, {String? customKey}) {
    try {
      final key = customKey != null ? Key(base64Decode(customKey)) : _key;
      final encrypter = Encrypter(AES(key));
      final iv = IV.fromSecureRandom(16);
      
      final encrypted = encrypter.encrypt(message, iv: iv);
      
      // Combine IV and encrypted data
      final combined = <int>[...iv.bytes, ...encrypted.bytes];
      return base64Encode(combined);
    } catch (e) {
      throw EncryptionException('Failed to encrypt message: $e');
    }
  }

  String decryptMessage(String encryptedMessage, {String? customKey}) {
    try {
      final key = customKey != null ? Key(base64Decode(customKey)) : _key;
      final encrypter = Encrypter(AES(key));
      
      final combined = base64Decode(encryptedMessage);
      
      // Extract IV and encrypted data
      final iv = IV(combined.sublist(0, 16));
      final encrypted = Encrypted(combined.sublist(16));
      
      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      throw EncryptionException('Failed to decrypt message: $e');
    }
  }

  String encryptFile(Uint8List fileData, {String? customKey}) {
    try {
      final key = customKey != null ? Key(base64Decode(customKey)) : _key;
      final encrypter = Encrypter(AES(key));
      final iv = IV.fromSecureRandom(16);
      
      final encrypted = encrypter.encryptBytes(fileData, iv: iv);
      
      // Combine IV and encrypted data
      final combined = <int>[...iv.bytes, ...encrypted.bytes];
      return base64Encode(combined);
    } catch (e) {
      throw EncryptionException('Failed to encrypt file: $e');
    }
  }

  Uint8List decryptFile(String encryptedFile, {String? customKey}) {
    try {
      final key = customKey != null ? Key(base64Decode(customKey)) : _key;
      final encrypter = Encrypter(AES(key));
      
      final combined = base64Decode(encryptedFile);
      
      // Extract IV and encrypted data
      final iv = IV(combined.sublist(0, 16));
      final encrypted = Encrypted(combined.sublist(16));
      
      return encrypter.decryptBytes(encrypted, iv: iv);
    } catch (e) {
      throw EncryptionException('Failed to decrypt file: $e');
    }
  }

  String doubleEncryptMessage(String message, String secondKey) {
    try {
      // First encryption with master key
      final firstEncrypted = encryptMessage(message);
      
      // Second encryption with custom key
      final secondKeyObj = Key(base64Decode(secondKey));
      final secondEncrypter = Encrypter(AES(secondKeyObj));
      final iv = IV.fromSecureRandom(16);
      
      final doubleEncrypted = secondEncrypter.encrypt(firstEncrypted, iv: iv);
      
      // Combine IV and double encrypted data
      final combined = <int>[...iv.bytes, ...doubleEncrypted.bytes];
      return base64Encode(combined);
    } catch (e) {
      throw EncryptionException('Failed to double encrypt message: $e');
    }
  }

  String doubleDecryptMessage(String encryptedMessage, String secondKey) {
    try {
      final secondKeyObj = Key(base64Decode(secondKey));
      final secondEncrypter = Encrypter(AES(secondKeyObj));
      
      final combined = base64Decode(encryptedMessage);
      
      // Extract IV and encrypted data
      final iv = IV(combined.sublist(0, 16));
      final encrypted = Encrypted(combined.sublist(16));
      
      // First decryption with second key
      final firstDecrypted = secondEncrypter.decrypt(encrypted, iv: iv);
      
      // Second decryption with master key
      return decryptMessage(firstDecrypted);
    } catch (e) {
      throw EncryptionException('Failed to double decrypt message: $e');
    }
  }

  String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  String generateSalt() {
    final random = Random.secure();
    final saltBytes = List<int>.generate(16, (i) => random.nextInt(256));
    return base64Encode(saltBytes);
  }

  bool verifyPassword(String password, String hash, String salt) {
    final hashedPassword = hashPassword(password, salt);
    return hashedPassword == hash;
  }

  String generateSecureToken() {
    final random = Random.secure();
    final tokenBytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Encode(tokenBytes);
  }

  Map<String, String> generateKeyPair() {
    final masterKey = generateKey();
    final secondaryKey = generateKey();
    
    return {
      'masterKey': masterKey,
      'secondaryKey': secondaryKey,
      'salt': generateSalt(),
    };
  }
}

class EncryptionException implements Exception {
  final String message;
  EncryptionException(this.message);
  
  @override
  String toString() => 'EncryptionException: $message';
}
