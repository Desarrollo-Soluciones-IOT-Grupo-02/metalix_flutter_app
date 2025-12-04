class CitizenProfileModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final int municipalityId;
  final String phone;
  final String address;
  final String city;
  final String zipCode;
  final bool isActive;
  final String rfidCard;
  final int totalPoints;
  final String createdAt;
  final String updatedAt;

  CitizenProfileModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.municipalityId,
    required this.phone,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.isActive,
    required this.rfidCard,
    required this.totalPoints,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CitizenProfileModel.fromJson(Map<String, dynamic> json) {
    return CitizenProfileModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      role: json['role'] ?? '',
      municipalityId: json['municipalityId'] ?? 0,
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      zipCode: json['zipCode'] ?? '',
      isActive: json['isActive'] ?? false,
      rfidCard: json['rfidCard'] ?? '',
      totalPoints: json['totalPoints'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
