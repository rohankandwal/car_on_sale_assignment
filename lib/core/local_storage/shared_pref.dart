import 'package:flutter_secure_storage/flutter_secure_storage.dart';

sealed class SharedPref {
  Future<String?> getString({required final String key});

  Future<void> saveString({
    required final String key,
    required final String data,
  });

  Future<void> clearData();
}

class SharedPrefImpl extends SharedPref {
  final FlutterSecureStorage storage;

  SharedPrefImpl(this.storage);

  @override
  Future<String?> getString({required final String key}) {
    return storage.read(key: key);
  }

  @override
  Future<void> saveString({
    required final String key,
    required final String data,
  }) {
    return storage.write(key: key, value: data);
  }

  @override
  Future<void> clearData() {
    return storage.deleteAll();
  }
}
