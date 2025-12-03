import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://metalix-backend.onrender.com/api/v1";

  static Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
