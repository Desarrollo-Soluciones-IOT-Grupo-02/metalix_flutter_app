import 'package:flutter/material.dart';

class CitizenDashboardView extends StatelessWidget {
  final Color mainColor = const Color(0xFF1FC7DB);

  const CitizenDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'icon': Icons.stars,
        'color': mainColor,
        'change': '+12%',
        'value': '257',
        'label': 'Total Points',
      },
      {
        'icon': Icons.recycling,
        'color': Colors.green,
        'change': '+8%',
        'value': '350',
        'label': 'Waste Collected (kg)',
      },
      {
        'icon': Icons.card_giftcard,
        'color': Colors.orange,
        'change': '+5%',
        'value': '1',
        'label': 'Rewards Earned',
      },
      {
        'icon': Icons.eco,
        'color': Colors.teal,
        'change': '+15%',
        'value': '128',
        'label': 'CO₂ Saved (kg)',
      },
    ];

    final quickActions = [
      {'icon': Icons.add_circle_outline, 'title': 'Add Collection'},
      {'icon': Icons.qr_code_scanner, 'title': 'Scan Reward'},
      {'icon': Icons.map_outlined, 'title': 'View Map'},
      {'icon': Icons.analytics_outlined, 'title': 'View Analytics'},
    ];

    final activities = [
      {
        'icon': Icons.recycling,
        'title': 'Metal waste collected',
        'time': '2 hours ago',
      },
      {
        'icon': Icons.card_giftcard,
        'title': 'Reward redeemed',
        'time': '1 day ago',
      },
      {
        'icon': Icons.eco,
        'title': 'Environmental impact achieved',
        'time': '3 days ago',
      },
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Stats Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stats.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final stat = stats[index];
              return _buildStatCard(
                stat['icon'] as IconData,
                stat['color'] as Color,
                stat['change'] as String,
                stat['value'] as String,
                stat['label'] as String,
              );
            },
          ),

          const SizedBox(height: 32),

          // 🔹 Quick Actions
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: quickActions.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.2,
            ),
            itemBuilder: (context, index) {
              final action = quickActions[index];
              return _buildQuickAction(
                action['icon'] as IconData,
                action['title'] as String,
              );
            },
          ),

          const SizedBox(height: 32),

          // 🔹 Recent Activity Section
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // 🔹 Activity List
          Column(
            children: activities.map((activity) {
              return _buildActivityItem(
                activity['icon'] as IconData,
                activity['title'] as String,
                activity['time'] as String,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      IconData icon,
      Color color,
      String change,
      String value,
      String label,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.15),
                  radius: 22,
                  child: Icon(icon, color: color, size: 24),
                ),
                Text(
                  change,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String title) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // Aquí luego se implementará la acción
        debugPrint('Quick Action: $title');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: mainColor.withOpacity(0.1),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: mainColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: mainColor.darken(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(IconData icon, String title, String time) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: mainColor.withOpacity(0.15),
          child: Icon(icon, color: mainColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(
          time,
          style: const TextStyle(color: Colors.black54, fontSize: 13),
        ),
      ),
    );
  }
}

extension ColorUtils on Color {
  Color darken([double amount = .1]) {
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
