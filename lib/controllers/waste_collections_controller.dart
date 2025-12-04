import 'package:metalixmovil/models/waste_collection_model.dart';
import 'package:metalixmovil/services/api_service.dart';

class WasteCollectionsController {
  // GET ALL
  static Future<List<WasteCollection>> getAll() async {
    final response = await ApiService.get('/waste-collections');

    return (response as List)
        .map((item) => WasteCollection.fromJson(item))
        .toList();
  }

  // GET BY ID
  static Future<WasteCollection> getById(int id) async {
    final response = await ApiService.get('/waste-collections/$id');
    return WasteCollection.fromJson(response);
  }

  // GET by User
  static Future<List<WasteCollection>> getByUser(int userId) async {
    final response = await ApiService.get('/waste-collections/user/$userId');

    return (response['content'] as List)
        .map((item) => WasteCollection.fromJson(item))
        .toList();
  }

  // GET by Municipality
  static Future<List<WasteCollection>> getByMunicipality(int municipalityId) async {
    final response = await ApiService.get('/waste-collections/municipality/$municipalityId');
    return (response as List)
        .map((item) => WasteCollection.fromJson(item))
        .toList();
  }

  // GET by Collector
  static Future<List<WasteCollection>> getByCollector(int collectorId) async {
    final response =
    await ApiService.get('/waste-collections/collector/$collectorId');

    return (response as List)
        .map((item) => WasteCollection.fromJson(item))
        .toList();
  }

  // CREATE
  static Future<WasteCollection> create(Map<String, dynamic> body) async {
    final response = await ApiService.post('/waste-collections', body);
    return WasteCollection.fromJson(response);
  }

  // UPDATE
  static Future<WasteCollection> update(int id, Map<String, dynamic> body) async {
    final response = await ApiService.put('/waste-collections/$id', body);
    return WasteCollection.fromJson(response);
  }

  // DELETE
  static Future<void> delete(int id) async {
    await ApiService.delete('/waste-collections/$id');
  }
}
