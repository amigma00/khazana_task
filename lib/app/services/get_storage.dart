import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _storage = GetStorage();

  void saveFunds(List<Map<String, dynamic>> funds) {
    _storage.write('funds', funds);
  }

  List<Map<String, dynamic>> getFunds() {
    return (_storage.read<List>('funds') ?? []).cast<Map<String, dynamic>>();
  }

  void clearFunds() {
    _storage.remove('funds');
  }
}
