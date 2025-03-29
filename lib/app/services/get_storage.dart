import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _storage = GetStorage();

  void saveFunds(Map<String, dynamic> funds) {
    _storage.write('funds', funds);
  }

  Map<String, dynamic> getFunds() {
    return (_storage.read('funds') ?? {});
  }

  void clearFunds() {
    _storage.remove('funds');
  }

  void saveAuthStatus(String isAuthenticated) {
    _storage.write('auth', isAuthenticated);
  }

  String isAuthenticated() {
    return _storage.read('auth') ?? 'false';
  }
}
