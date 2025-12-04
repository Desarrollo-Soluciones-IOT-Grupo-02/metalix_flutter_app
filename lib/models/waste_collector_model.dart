class WasteCollector {
  final int id;
  final String name;
  final String type;
  final String location;
  final int municipalityId;
  final int zoneId;
  final int capacity;
  final int currentFill;
  final String lastCollection;
  final String nextScheduledCollection;
  final String status;
  final String sensorId;
  final double fillPercentage;

  WasteCollector({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.municipalityId,
    required this.zoneId,
    required this.capacity,
    required this.currentFill,
    required this.lastCollection,
    required this.nextScheduledCollection,
    required this.status,
    required this.sensorId,
    required this.fillPercentage,
  });

  factory WasteCollector.fromJson(Map<String, dynamic> json) {
    return WasteCollector(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      location: json['location'] ?? '',
      municipalityId: json['municipalityId'] ?? 0,
      zoneId: json['zoneId'] ?? 0,
      capacity: json['capacity'] ?? 0,
      currentFill: json['currentFill'] ?? 0,
      lastCollection: json['lastCollection'] ?? '',
      nextScheduledCollection: json['nextScheduledCollection'] ?? '',
      status: json['status'] ?? '',
      sensorId: json['sensorId'] ?? '',
      fillPercentage: (json['fillPercentage'] ?? 0).toDouble(),
    );
  }
}
