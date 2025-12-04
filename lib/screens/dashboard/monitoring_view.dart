import 'package:flutter/material.dart';

class MonitoringView extends StatefulWidget {
  const MonitoringView({super.key});

  @override
  State<MonitoringView> createState() => _MonitoringViewState();
}

class _MonitoringViewState extends State<MonitoringView> {
  final Color mainColor = const Color(0xFF1FC7DB);

  // Fake monitoring data
  final Map<String, dynamic> monitorData = {
    "name": "Municipality A",
    "region": "Zone 1",
    "code": "MN-001",
    "lastUpdated": "2025-01-10 14:53",
    "status": "Active",
    "stats": {
      "totalUsers": 4850,
      "activeUsers": 3120,
      "totalCollections": 12430,
      "totalPointsDistributed": 98200,
      "systemUptime": "99.2%",
      "averageResponseTime": "184ms",
    }
  };

  final List<Map<String, dynamic>> alerts = [
    {
      "id": 1,
      "severity": "high",
      "type": "system",
      "message": "RFID reader malfunction detected",
      "timestamp": "2 hours ago"
    },
    {
      "id": 2,
      "severity": "medium",
      "type": "capacity",
      "message": "Point A nearing max capacity",
      "timestamp": "6 hours ago"
    },
    {
      "id": 3,
      "severity": "low",
      "type": "info",
      "message": "Scheduled maintenance completed",
      "timestamp": "1 day ago"
    }
  ];

  final List<Map<String, dynamic>> userActivity = [
    {
      "name": "Ana Lopez",
      "email": "ana.lopez@example.com",
      "lastActivity": "1 hour ago",
      "totalCollections": 12,
      "totalPoints": 240,
      "status": "Active"
    },
    {
      "name": "Juan Perez",
      "email": "juan.perez@example.com",
      "lastActivity": "3 hours ago",
      "totalCollections": 7,
      "totalPoints": 110,
      "status": "Inactive"
    },
  ];

  final List<Map<String, dynamic>> analytics = [
    {"period": "This Week", "collections": 520, "points": 11230, "waste": 210},
    {"period": "This Month", "collections": 2040, "points": 45210, "waste": 930},
    {"period": "This Year", "collections": 18400, "points": 389200, "waste": 8120},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          const SizedBox(height: 20),
          _systemStats(),
          const SizedBox(height: 24),
          _alertsSection(),
          const SizedBox(height: 24),
          _userActivity(),
          const SizedBox(height: 24),
          _collectionAnalytics(),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================
  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: mainColor.withOpacity(.2),
          child: const Icon(Icons.analytics, size: 30),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                monitorData["name"],
                style:
                const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Text(
                "Monitoring & System Analytics",
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                "Last updated: ${monitorData["lastUpdated"]}",
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // GRID SYSTEM STATS
  // ============================================================
  Widget _systemStats() {
    final s = monitorData["stats"];

    final List<Map<String, dynamic>> items = [
      {"icon": Icons.people, "label": "Total Users", "value": s["totalUsers"]},
      {
        "icon": Icons.person,
        "label": "Active Users",
        "value": s["activeUsers"],
      },
      {
        "icon": Icons.recycling,
        "label": "Collections",
        "value": s["totalCollections"]
      },
      {
        "icon": Icons.stars,
        "label": "Points",
        "value": s["totalPointsDistributed"]
      },
      {"icon": Icons.schedule, "label": "Uptime", "value": s["systemUptime"]},
      {
        "icon": Icons.speed,
        "label": "Avg Response",
        "value": s["averageResponseTime"]
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (_, i) {
        final item = items[i];
        return Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: mainColor.withOpacity(.2),
                  child: Icon(item["icon"], color: mainColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${item["value"]}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(item["label"],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // ALERTS
  // ============================================================
  Widget _alertsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("System Alerts",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: alerts.length,
          itemBuilder: (_, i) {
            final alert = alerts[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red.withOpacity(.15),
                  child: const Icon(Icons.warning, color: Colors.red),
                ),
                title: Text(alert["message"]),
                subtitle: Text(alert["timestamp"]),
                trailing: Chip(
                  label: Text(alert["severity"].toUpperCase()),
                  backgroundColor: Colors.red.withOpacity(.15),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // USER ACTIVITY
  // ============================================================
  Widget _userActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("User Activity",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: userActivity.length,
          itemBuilder: (_, i) {
            final u = userActivity[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: mainColor.withOpacity(.2),
                  child: const Icon(Icons.person),
                ),
                title: Text(u["name"]),
                subtitle: Text("${u["email"]}\nLast: ${u["lastActivity"]}"),
                trailing: Chip(
                  label: Text("${u["totalPoints"]} pts"),
                  backgroundColor: mainColor.withOpacity(.15),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  // ============================================================
  // COLLECTION ANALYTICS
  // ============================================================
  Widget _collectionAnalytics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Collection Analytics",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        ...analytics.map((a) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(a["period"],
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text(
                "${a["collections"]} collections • ${a["points"]} points • ${a["waste"]} kg waste"),
          ),
        )),
      ],
    );
  }
}
