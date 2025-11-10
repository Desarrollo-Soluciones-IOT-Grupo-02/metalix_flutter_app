import 'package:flutter/material.dart';

class WasteCollectionView extends StatefulWidget {
  const WasteCollectionView({super.key});

  @override
  State<WasteCollectionView> createState() => _WasteCollectionViewState();
}

class _WasteCollectionViewState extends State<WasteCollectionView> {
  final Color mainColor = const Color(0xFF1FC7DB);
  bool isLoading = false;

  final stats = [
    {
      'icon': Icons.recycling,
      'color': const Color(0xFF1FC7DB),
      'change': '+8%',
      'value': '1,050 kg',
      'label': 'Total Waste Collected',
    },
    {
      'icon': Icons.stars,
      'color': Colors.orange,
      'change': '+12%',
      'value': '8,250',
      'label': 'Points Earned',
    },
    {
      'icon': Icons.history,
      'color': Colors.blueAccent,
      'change': '+3',
      'value': '45',
      'label': 'Collection Sessions',
    },
    {
      'icon': Icons.eco,
      'color': Colors.green,
      'change': '+15%',
      'value': '680 kg',
      'label': 'CO₂ Saved',
    },
  ];

  final List<Map<String, dynamic>> collectionPoints = [
    {
      'name': 'Metalix Center A',
      'address': 'Av. Principal 123, Lima',
      'hours': 'Mon–Fri 8:00–17:00',
      'distance': '2.3 km',
      'status': 'Open',
    },
    {
      'name': 'Municipal Recycling Point',
      'address': 'Calle Verde 45, Callao',
      'hours': 'Mon–Sat 9:00–16:00',
      'distance': '4.1 km',
      'status': 'Closed',
    },
    {
      'name': 'EcoPark Station',
      'address': 'Av. Ambiental 80, Miraflores',
      'hours': 'Daily 8:00–18:00',
      'distance': '5.2 km',
      'status': 'Open',
    },
  ];

  final List<Map<String, dynamic>> collectionHistory = [
    {
      'wasteType': 'Aluminum Cans',
      'weight': '2.5',
      'points': 25,
      'location': 'Metalix Center A',
      'date': '2 hours ago',
    },
    {
      'wasteType': 'Copper Wires',
      'weight': '1.2',
      'points': 15,
      'location': 'EcoPark Station',
      'date': '1 day ago',
    },
    {
      'wasteType': 'Steel Scrap',
      'weight': '5.8',
      'points': 45,
      'location': 'Municipal Recycling Point',
      'date': '3 days ago',
    },
  ];

  void _startCollection() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Collection process started successfully!'),
        backgroundColor: mainColor,
      ),
    );
  }

  Color _getStatusColor(String status) {
    return status == 'Open' ? Colors.green : Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
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

          // 🔹 Quick Action
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              icon: isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Icon(Icons.add, color: Colors.white),
              label: Text(
                isLoading ? 'Processing...' : 'Start Collection',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: isLoading ? null : _startCollection,
            ),
          ),

          const SizedBox(height: 32),

          // 🔹 Collection Points
          const Text(
            'Available Collection Points',
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
            itemCount: collectionPoints.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              final point = collectionPoints[index];
              return _buildCollectionPointCard(point);
            },
          ),

          const SizedBox(height: 32),

          // 🔹 Collection History
          const Text(
            'Recent Collections',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: collectionHistory.map((item) {
              return _buildCollectionHistoryItem(item);
            }).toList(),
          ),
        ],
      ),
    );
  }

  // --- 🧱 COMPONENTES ---

  Widget _buildStatCard(
      IconData icon, Color color, String change, String value, String label) {
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

  Widget _buildCollectionPointCard(Map<String, dynamic> point) {
    final bool isClosed = point['status'] == 'Closed';

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isClosed ? Colors.grey.shade100 : Colors.white,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        constraints: const BoxConstraints(minHeight: 130, maxHeight: 160),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(point['name'],
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(point['address'],
                style: const TextStyle(color: Colors.black54, fontSize: 13)),
            const SizedBox(height: 8),

            // Info Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoItem(Icons.schedule, point['hours']),
                _infoItem(Icons.place, point['distance']),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle,
                        size: 10, color: _getStatusColor(point['status'])),
                    const SizedBox(width: 4),
                    Text(
                      point['status'],
                      style: TextStyle(
                        color: _getStatusColor(point['status']),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            // Button
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton.icon(
                onPressed: isClosed
                    ? null
                    : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                      Text('Opening map for ${point['name']}...'),
                      backgroundColor: mainColor,
                    ),
                  );
                },
                icon: const Icon(Icons.directions, size: 18),
                label: const Text('Get Directions',
                    style: TextStyle(fontSize: 13)),
                style: TextButton.styleFrom(
                  foregroundColor:
                  isClosed ? Colors.grey : mainColor.darken(),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionHistoryItem(Map<String, dynamic> item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: mainColor.withOpacity(0.15),
          child: const Icon(Icons.recycling, color: Colors.teal),
        ),
        title: Text(
          item['wasteType'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${item['weight']} kg • ${item['points']} points • ${item['location']}',
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
            Text(
              item['date'],
              style: const TextStyle(color: Colors.black45, fontSize: 12),
            ),
          ],
        ),
        trailing: Chip(
          backgroundColor: mainColor.withOpacity(0.1),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.stars, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                '${item['points']}',
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
        ),
      ],
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
