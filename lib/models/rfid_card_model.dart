class RfidCardModel {
  final int id;
  final String cardNumber;
  final int userId;
  final String status;
  final String issuedDate;
  final String expirationDate;
  final String lastUsed;
  final bool valid;

  RfidCardModel({
    required this.id,
    required this.cardNumber,
    required this.userId,
    required this.status,
    required this.issuedDate,
    required this.expirationDate,
    required this.lastUsed,
    required this.valid,
  });

  factory RfidCardModel.fromJson(Map<String, dynamic> json) {
    return RfidCardModel(
      id: json['id'] ?? 0,
      cardNumber: json['cardNumber'] ?? '',
      userId: json['userId'] ?? 0,
      status: json['status'] ?? '',
      issuedDate: json['issuedDate'] ?? '',
      expirationDate: json['expirationDate'] ?? '',
      lastUsed: json['lastUsed'] ?? '',
      valid: json['valid'] ?? false,
    );
  }

  // ⭐⭐⭐ AQUI ESTÁ EL COPYWITH ⭐⭐⭐
  RfidCardModel copyWith({
    int? id,
    String? cardNumber,
    int? userId,
    String? status,
    String? issuedDate,
    String? expirationDate,
    String? lastUsed,
    bool? valid,
  }) {
    return RfidCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      issuedDate: issuedDate ?? this.issuedDate,
      expirationDate: expirationDate ?? this.expirationDate,
      lastUsed: lastUsed ?? this.lastUsed,
      valid: valid ?? this.valid,
    );
  }
}
