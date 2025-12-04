import 'package:flutter/material.dart';
import 'package:metalixmovil/models/citizen_profile_model.dart';
import 'package:metalixmovil/services/user_service.dart';

class ProfileView extends StatefulWidget {
  final int userId;
  final String token;

  const ProfileView({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final Color mainColor = const Color(0xFF1FC7DB);

  CitizenProfileModel? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      profile = await UserService.getUserById(widget.userId, widget.token);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading profile: $e")),
      );
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profile == null) {
      return const Center(child: Text("Profile not found"));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildInfoCard(),
          const SizedBox(height: 20),
          _buildStatsCard(),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================
  Widget _buildHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: mainColor.withOpacity(0.2),
              child: const Icon(Icons.person, size: 60, color: Colors.grey),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${profile!.firstName} ${profile!.lastName}",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  profile!.role,
                  style: const TextStyle(color: Colors.black54),
                ),
                Text(
                  "Member since ${profile!.createdAt.split('T')[0]}",
                  style: const TextStyle(color: Colors.black38, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // INFO CARD
  // ============================================================
  Widget _buildInfoCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _row("Email", profile!.email),
            _row("Phone", profile!.phone),
            _row("Address", profile!.address),
            _row("City", profile!.city),
            _row("ZIP Code", profile!.zipCode),
            _row("Municipality ID", profile!.municipalityId.toString()),
            _row("RFID Card", profile!.rfidCard ?? "-"),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black54)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATS CARD
  // ============================================================
  Widget _buildStatsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _stat(Icons.stars, "Total Points",
                profile!.totalPoints.toString(), mainColor),
          ],
        ),
      ),
    );
  }

  Widget _stat(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ],
    );
  }
}
