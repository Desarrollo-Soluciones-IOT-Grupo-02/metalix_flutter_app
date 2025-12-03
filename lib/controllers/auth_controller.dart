import 'package:metalixmovil/models/user_model.dart';
import 'package:metalixmovil/services/api_service.dart';

class AuthController {
  // 🔹 LOGIN
  static Future<UserModel?> login(String email, String password) async {
    try {
      final response = await ApiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      if (response['token'] != null) {
        return UserModel.fromJson(response);
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
