class WasteCollection {
  final int id;
  final int userId;
  final int collectorId;
  final double weight;
  final String recyclableType;
  final int points;
  final bool verified;
  final String verificationMethod;
  final int municipalityId;
  final int zoneId;
  final DateTime timestamp;

  WasteCollection({
    required this.id,
    required this.userId,
    required this.collectorId,
    required this.weight,
    required this.recyclableType,
    required this.points,
    required this.verified,
    required this.verificationMethod,
    required this.municipalityId,
    required this.zoneId,
    required this.timestamp,
  });

  factory WasteCollection.fromJson(Map<String, dynamic> json) {
    return WasteCollection(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      collectorId: json['collectorId'] ?? 0,
      weight: (json['weight'] ?? 0).toDouble(),
      recyclableType: json['recyclableType'] ?? "",
      points: json['points'] ?? 0,
      verified: json['verified'] ?? false,
      verificationMethod: json['verificationMethod'] ?? "",
      municipalityId: json['municipalityId'] ?? 0,
      zoneId: json['zoneId'] ?? 0,
      timestamp: DateTime.tryParse(json['timestamp'] ?? "") ?? DateTime.now(),
    );
  }
}
