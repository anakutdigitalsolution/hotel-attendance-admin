import 'package:hotle_attendnce_admin/src/utils/service/storage.dart';

class AuthenticationRepository {
  Storage _storage = Storage();
  Future<void> saveToken({required String token}) async {
    await _storage.saveToken(token: token);
  }

  Future<String?> getToken() async {
    return await _storage.getToken();
  }
  

  Future<void> removeToken() async {
    return await _storage.removeToken();
  }
}
