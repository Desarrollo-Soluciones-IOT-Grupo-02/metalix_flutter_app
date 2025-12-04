import 'package:metalixmovil/models/citizen_profile_model.dart';
import 'package:metalixmovil/services/api_service.dart';

class UserService {
  // GET /users/{id}
  static Future<CitizenProfileModel> getUserById(int id, String token) async {
    final response = await ApiService.get('/users/$id', token: token);
    return CitizenProfileModel.fromJson(response);
  }

}
