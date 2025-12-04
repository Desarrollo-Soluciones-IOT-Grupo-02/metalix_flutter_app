import 'package:metalixmovil/models/rfid_card_model.dart';
import 'package:metalixmovil/services/api_service.dart';

class RfidService {

  // -------------------------------------------
  // GET all RFID cards
  // -------------------------------------------
  static Future<List<RfidCardModel>> getAllCards() async {
    final response = await ApiService.get('/rfid-cards');

    return (response as List)
        .map((json) => RfidCardModel.fromJson(json))
        .toList();
  }

  // -------------------------------------------
  // GET cards by USER ID  --> RETURNS LIST!!
  // -------------------------------------------
  static Future<List<RfidCardModel>> getCardsByUser(int userId) async {
    final response = await ApiService.get('/rfid-cards/user/$userId');

    return (response as List)
        .map((json) => RfidCardModel.fromJson(json))
        .toList();
  }

  // -------------------------------------------
  // CREATE RFID CARD
  // -------------------------------------------
  static Future<RfidCardModel> createCard(String cardNumber, int userId) async {
    final body = {
      "cardNumber": cardNumber,
      "userId": userId,
      "status": "ACTIVE",
      "issuedDate": DateTime.now().toString().split(" ").first,
      "expirationDate":
      DateTime.now().add(const Duration(days: 365)).toString().split(" ").first,
      "valid": true,
    };

    final response = await ApiService.post('/rfid-cards', body);
    return RfidCardModel.fromJson(response);
  }

  // -------------------------------------------
  // LINK card to logged user
  // -------------------------------------------
  static Future<dynamic> linkCardToUser(String cardNumber) async {
    return await ApiService.post('/rfid-cards/link', {
      "cardNumber": cardNumber,
    });
  }

  // -------------------------------------------
  // BLOCK CARD
  // ApiService.patch() does NOT accept a body
  // -------------------------------------------
  static Future<dynamic> blockCard(int id) async {
    return await ApiService.patch('/rfid-cards/$id/block');
  }

  // -------------------------------------------
  // USE RFID CARD
  // -------------------------------------------
  static Future<dynamic> useCard(String cardNumber) async {
    return await ApiService.post('/rfid-cards/use/$cardNumber', {});
  }
}
