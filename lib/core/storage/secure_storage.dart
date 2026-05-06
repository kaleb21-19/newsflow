import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage(this._storage);

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';

  // Access token
  Future<void> saveAccessToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  Future<String?> getAccessToken() =>
      _storage.read(key: _accessTokenKey);

  // Refresh token
  Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _refreshTokenKey, value: token);

  Future<String?> getRefreshToken() =>
      _storage.read(key: _refreshTokenKey);

  // User ID
  Future<void> saveUserId(String id) =>
      _storage.write(key: _userIdKey, value: id);

  Future<String?> getUserId() =>
      _storage.read(key: _userIdKey);

  // Clear everything — on logout
  Future<void> clearAll() => _storage.deleteAll();
}