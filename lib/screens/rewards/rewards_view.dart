import 'package:flutter/material.dart';

class RewardsView extends StatelessWidget {
  const RewardsView({super.key});

  final Color mainColor = const Color(0xFF1FC7DB);

  final Map<String, dynamic> stats = const {
    'totalPoints': 8250,
    'availablePoints': 5400,
    'redeemedPoints': 2850,
    'rewardsEarned': 12,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Points Overview Header
          _buildPointsOverview(context),

          const SizedBox(height: 32),

          // 🔹 Points Stats Grid
          const Text(
            'Points Summary',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatsGrid(),

          const SizedBox(height: 32),

          // 🔹 Rewards Tabs Section
          DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TabBar(
                  labelColor: Colors.black87,
                  indicatorColor: Color(0xFF1FC7DB),
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    Tab(text: 'Available Rewards', icon: Icon(Icons.card_giftcard)),
                    Tab(text: 'My Rewards', icon: Icon(Icons.emoji_events)),
                    Tab(text: 'Points History', icon: Icon(Icons.history)),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 600,
                  child: TabBarView(
                    children: [
                      _AvailableRewardsTab(),
                      _MyRewardsTab(),
                      _PointsHistoryTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 🔹 COMPONENTES ---

  Widget _buildPointsOverview(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Ícono
            CircleAvatar(
              radius: 40,
              backgroundColor: mainColor.withOpacity(0.15),
              child: const Icon(
                Icons.stars,
                color: Colors.amber,
                size: 42,
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Título
            Text(
              '${stats['totalPoints']} Points',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 6),

            // 🔹 Subtítulo
            Text(
              'Available: ${stats['availablePoints']} points',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Botón centrado debajo del texto
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.recycling, color: Colors.white),
                label: const Text(
                  'Earn More Points',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/waste-collection');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    final List<Map<String, dynamic>> statItems = [
      {
        'icon': Icons.stars,
        'color': const Color(0xFF1FC7DB),
        'label': 'Total Points',
        'value': '${stats['totalPoints']}',
      },
      {
        'icon': Icons.account_balance_wallet,
        'color': Colors.orange,
        'label': 'Available Points',
        'value': '${stats['availablePoints']}',
      },
      {
        'icon': Icons.card_giftcard,
        'color': Colors.blueAccent,
        'label': 'Redeemed Points',
        'value': '${stats['redeemedPoints']}',
      },
      {
        'icon': Icons.emoji_events,
        'color': Colors.green,
        'label': 'Rewards Earned',
        'value': '${stats['rewardsEarned']}',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: statItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final item = statItems[index];
        return _buildStatCard(
          item['icon'] as IconData,
          item['color'] as Color,
          item['value'] as String,
          item['label'] as String,
        );
      },
    );
  }

  Widget _buildStatCard(
      IconData icon, Color color, String value, String label) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              radius: 24,
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
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
}

// ===========================================================
// 🔹 Available Rewards Tab
// ===========================================================
class _AvailableRewardsTab extends StatelessWidget {
  final Color mainColor = const Color(0xFF1FC7DB);

  final List<Map<String, dynamic>> availableRewards = [
    {
      'name': 'Reusable Bottle',
      'category': 'Eco Accessories',
      'description': 'Exchange your points for a durable eco-friendly bottle.',
      'pointsRequired': 500,
      'available': true,
      'icon': Icons.water_drop,
    },
    {
      'name': 'Discount Voucher',
      'category': 'Local Stores',
      'description': 'Get 10% off in participating eco-friendly stores.',
      'pointsRequired': 800,
      'available': true,
      'icon': Icons.local_offer,
    },
    {
      'name': 'Eco Tote Bag',
      'category': 'Sustainable Goods',
      'description':
      'Redeem an eco-friendly tote bag made from recycled cotton. Ideal for everyday use and shopping sustainably.',
      'pointsRequired': 650,
      'available': true,
      'icon': Icons.shopping_bag,
    },
    {
      'name': 'Tree Planting Donation',
      'category': 'Environmental Action',
      'description':
      'Donate your points to support reforestation initiatives in the Amazon rainforest.',
      'pointsRequired': 1000,
      'available': false,
      'icon': Icons.park,
    },
  ];



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: availableRewards.map((reward) {
            final bool isAvailable = reward['available'] as bool;

            return SizedBox(
              width: isWide
                  ? (constraints.maxWidth / 2) - 20
                  : constraints.maxWidth,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: isAvailable ? Colors.white : Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 Header (icon + name)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: mainColor.withOpacity(0.15),
                              child: Icon(
                                reward['icon'] as IconData,
                                color: mainColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reward['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    reward['category'],
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // 🔹 Description (auto height)
                        Text(
                          reward['description'],
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 8),
                        const Spacer(),

                        // 🔹 Footer: Points chip + button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.stars,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text('${reward['pointsRequired']} pts'),
                                ],
                              ),
                              backgroundColor: mainColor.withOpacity(0.1),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.card_giftcard,
                                color: Colors.white,
                                size: 18,
                              ),
                              label: const Text('Redeem'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                isAvailable ? mainColor : Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: isAvailable
                                  ? () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Redeemed ${reward['name']} successfully!'),
                                    backgroundColor: mainColor,
                                  ),
                                );
                              }
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}


// ===========================================================
// 🔹 My Rewards Tab
// ===========================================================
class _MyRewardsTab extends StatelessWidget {
  final List<Map<String, dynamic>> redeemedRewards = const [
    {
      'icon': Icons.local_cafe,
      'name': 'Free Coffee Voucher',
      'pointsUsed': 200,
      'redeemedDate': '2 days ago',
      'status': 'Used',
    },
    {
      'icon': Icons.shopping_bag,
      'name': 'Eco Tote Bag',
      'pointsUsed': 450,
      'redeemedDate': '1 week ago',
      'status': 'Pending',
    },
  ];

  const _MyRewardsTab({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Used':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: redeemedRewards.length,
      itemBuilder: (context, index) {
        final reward = redeemedRewards[index];
        return Card(
          elevation: 2,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal.withOpacity(0.1),
              child: Icon(reward['icon'] as IconData, color: Colors.teal),
            ),
            title: Text(
              reward['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${reward['pointsUsed']} points • ${reward['redeemedDate']}',
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
            trailing: Chip(
              label: Text(reward['status']),
              backgroundColor:
              _getStatusColor(reward['status']).withOpacity(0.15),
              labelStyle: TextStyle(
                color: _getStatusColor(reward['status']),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ===========================================================
// 🔹 Points History Tab
// ===========================================================
class _PointsHistoryTab extends StatelessWidget {
  final List<Map<String, dynamic>> pointsHistory = const [
    {
      'description': 'Redeemed Coffee Voucher',
      'date': 'Today',
      'points': -200,
      'type': 'redeem',
    },
    {
      'description': 'Waste Collection - 2.5kg',
      'date': 'Yesterday',
      'points': 25,
      'type': 'earn',
    },
    {
      'description': 'Recycled Electronics',
      'date': '3 days ago',
      'points': 60,
      'type': 'earn',
    },
  ];

  const _PointsHistoryTab({super.key});

  Color _getPointsColor(int points) {
    return points > 0 ? Colors.green : Colors.redAccent;
  }

  IconData _getPointsIcon(String type) {
    return type == 'earn' ? Icons.add_circle : Icons.remove_circle;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: pointsHistory.length,
      itemBuilder: (context, index) {
        final entry = pointsHistory[index];
        return Card(
          elevation: 2,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: Icon(
              _getPointsIcon(entry['type']),
              color: _getPointsColor(entry['points']),
              size: 30,
            ),
            title: Text(entry['description'],
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(entry['date'],
                style: const TextStyle(color: Colors.black54, fontSize: 13)),
            trailing: Chip(
              label: Text(
                '${entry['points'] > 0 ? '+' : ''}${entry['points']}',
                style: TextStyle(
                  color: _getPointsColor(entry['points']),
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: _getPointsColor(entry['points']).withOpacity(0.1),
            ),
          ),
        );
      },
    );
  }
}
