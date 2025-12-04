import 'dart:convert';
import 'package:http/http.dart' as http;

class BanistaCardService {
  static const String baseUrl =
      "http://metalix-backend.fwdjcrbjcfahdbem.westus2.azurecontainer.io:8000";

  // GET /cards/banista/{id_banista}
  static Future<List<Map<String, dynamic>>> getCardsByBanista(int banistaId) async {
    final url = Uri.parse("$baseUrl/cards/banista/$banistaId");

    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("Error fetching cards: ${res.body}");
    }

    return List<Map<String, dynamic>>.from(jsonDecode(res.body));
  }

  // POST /cards/code/{card_code}/vincular
  static Future<void> linkCard(String cardCode, int banistaId) async {
    final url = Uri.parse("$baseUrl/cards/code/$cardCode/vincular");

    final body = {
      "id_banista": banistaId,
    };

    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception("Error linking card: ${res.body}");
    }
  }

  // POST /cards/code/{card_code}/desvincular
  static Future<void> unlinkCard(String cardCode) async {
    final url = Uri.parse("$baseUrl/cards/code/$cardCode/desvincular");

    final res = await http.post(url);

    if (res.statusCode != 200) {
      throw Exception("Error unlinking card: ${res.body}");
    }
  }
}
