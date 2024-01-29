import 'package:client/services/secure_storage_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_secure_storage/get_secure_storage.dart';

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

class SecureStorageService {
  static const passwordKey = 'secure_storage_password';

  static Future<void> init() async {
    await GetSecureStorage.init(password: passwordKey);
  }

  // GENERAL
  final box = GetSecureStorage(password: passwordKey);

  void write(SecureStorageEnum key, String value) {
    box.write(key.name, value);
  }

  String? read(SecureStorageEnum key) {
    return box.read(key.name);
  }

  void delete(SecureStorageEnum key) {
    box.remove(key.name);
  }

  void deleteAll() {
    box.erase();
  }

  // TOKEN
  void writeToken(String token) {
    write(SecureStorageEnum.token, token);
  }

  String? readToken() {
    return read(SecureStorageEnum.token);
  }

  void deleteToken() {
    delete(SecureStorageEnum.token);
    delete(SecureStorageEnum.userInfo);
  }

  VoidCallback listenToken(void Function(dynamic newToken) onTokenChanged) {
    return box.listenKey(
      SecureStorageEnum.token.name,
      onTokenChanged,
    );
  }

}
