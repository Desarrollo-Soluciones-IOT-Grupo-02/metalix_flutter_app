import 'dart:convert';
import 'package:metalixmovil/models/waste_collector_model.dart';
import 'package:metalixmovil/services/api_service.dart';

class WasteCollectorController {

  // 🔹 GET ALL Waste Collectors
  static Future<List<WasteCollector>> getAllCollectors() async {
    final response = await ApiService.get('/waste-collectors');

    return (response as List)
        .map((item) => WasteCollector.fromJson(item))
        .toList();
  }

  // 🔹 GET one by ID
  static Future<WasteCollector> getCollectorById(int id) async {
    final response = await ApiService.get('/waste-collectors/$id');
    return WasteCollector.fromJson(response);
  }

  // 🔹 CREATE collector
  static Future<WasteCollector> createCollector(Map<String, dynamic> data) async {
    final response = await ApiService.post('/waste-collectors', data);
    return WasteCollector.fromJson(response);
  }

  // 🔹 UPDATE collector
  static Future<WasteCollector> updateCollector(int id, Map<String, dynamic> data) async {
    final response = await ApiService.put('/waste-collectors/$id', data);
    return WasteCollector.fromJson(response);
  }

  // 🔹 DELETE collector
  static Future<void> deleteCollector(int id) async {
    await ApiService.delete('/waste-collectors/$id');
  }

  // 🔹 EMPTY collector
  static Future<WasteCollector> emptyCollector(int id) async {
    final response = await ApiService.patch('/waste-collectors/$id/empty');
    return WasteCollector.fromJson(response);
  }
}
