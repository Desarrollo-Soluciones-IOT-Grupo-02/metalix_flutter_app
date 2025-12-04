import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://metalix-backend.onrender.com/api/v1";

  // ------------------------------
  // 🔹 POST
  // ------------------------------
  static Future<dynamic> post(
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
      throw Exception('POST Error ${response.statusCode}: ${response.body}');
    }
  }

  // ------------------------------
  // 🔹 GET
  // ------------------------------
  static Future<dynamic> get(String endpoint, {String? token}) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final headers = {
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('GET Error ${response.statusCode}: ${response.body}');
    }
  }


  // ------------------------------
  // 🔹 PUT
  // ------------------------------
  static Future<dynamic> put(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('PUT Error ${response.statusCode}: ${response.body}');
    }
  }

  // ------------------------------
  // 🔹 DELETE
  // ------------------------------
  static Future<void> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final response = await http.delete(url);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('DELETE Error ${response.statusCode}: ${response.body}');
    }
  }

  // ------------------------------
  // 🔹 PATCH (soporta body opcional)
  // ------------------------------
  static Future<dynamic> patch(
      String endpoint, [
        Map<String, dynamic>? body,
      ]) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.patch(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('PATCH Error ${response.statusCode}: ${response.body}');
    }
  }
}
