import 'dart:convert';
import 'package:http/http.dart' as http;

class BanistaApiService {
  static const String baseUrl = "http://metalix-backend.fwdjcrbjcfahdbem.westus2.azurecontainer.io:8000";

  // GET
  static Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('GET Error ${response.statusCode}: ${response.body}');
    }
  }

  // POST
  static Future<dynamic> post(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final response = await http.post(url, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('POST Error ${response.statusCode}: ${response.body}');
    }
  }
}
