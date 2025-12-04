import 'package:flutter/material.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  final Color mainColor = const Color(0xFF1FC7DB);

  // -------------------------------
  // 🔹 Filtros (fake)
  // -------------------------------
  String? selectedMunicipality = "All";
  String? selectedMaterial = "All";
  DateTimeRange? selectedDateRange;

  final List<String> municipalities = [
    "All",
    "Zone1",
    "Zone2",
    "Zone3",
  ];

  final List<String> materials = [
    "All",
    "Plastic",
    "Metal",
    "Paper",
  ];

  // -------------------------------
  // 🔹 Datos fake tipados
  // -------------------------------
  final List<Map<String, dynamic>> stats = [
    {
      'icon': Icons.location_city,
      'color': Colors.blue,
      'value': "12",
      'label': "Municipalities",
    },
    {
      'icon': Icons.people,
      'color': Colors.green,
      'value': "4,850",
      'label': "Citizens Registered",
    },
    {
      'icon': Icons.recycling,
      'color': Colors.orange,
      'value': "12,430",
      'label': "Total Collections",
    },
    {
      'icon': Icons.scale,
      'color': Colors.purple,
      'value': "52,180 kg",
      'label': "Waste Collected",
    },
    {
      'icon': Icons.stars,
      'color': Colors.teal,
      'value': "98,200",
      'label': "Points Distributed",
    },
    {
      'icon': Icons.warning,
      'color': Colors.red,
      'value': "3",
      'label': "Active Alerts",
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {"icon": Icons.person_add, "label": "Register Citizen"},
    {"icon": Icons.recycling, "label": "Add Waste Record"},
    {"icon": Icons.map, "label": "Manage Zones"},
    {"icon": Icons.business, "label": "Municipality Settings"},
  ];

  final List<Map<String, dynamic>> topCollectionPoints = [
    {"name": "Point A", "collections": 210, "status": "ACTIVE"},
    {"name": "Point B", "collections": 180, "status": "ACTIVE"},
    {"name": "Point C", "collections": 150, "status": "MAINTENANCE"},
  ];

  final List<Map<String, dynamic>> materialDistribution = [
    {"type": "Plastic", "percentage": 40},
    {"type": "Metal", "percentage": 30},
    {"type": "Paper", "percentage": 30},
  ];

  final List<Map<String, dynamic>> zonePerformance = [
    {"zone": "Zone 1", "collections": 500},
    {"zone": "Zone 2", "collections": 390},
    {"zone": "Zone 3", "collections": 320},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================
          // 🔹 Título + subtítulo
          // ============================
          const Text(
            "Admin Analytics Dashboard",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "",
            style: TextStyle(color: Colors.black54),
          ),

          const SizedBox(height: 16),

          // ============================
          // 🔹 Filtros
          // ============================
          _buildFilters(),

          const SizedBox(height: 24),

          // ============================
          // 🔹 Stats Cards
          // ============================
          _buildStatsGrid(),

          const SizedBox(height: 32),

          // ============================
          // 🔹 Quick Actions
          // ============================
          _buildQuickActions(),

          const SizedBox(height: 32),

          // ============================
          // 🔹 Top Collection Points
          // ============================
          _buildTopCollectionPoints(),

          const SizedBox(height: 32),

          // ============================
          // 🔹 Material Distribution
          // ============================
          _buildMaterialDistribution(),

          const SizedBox(height: 32),

          // ============================
          // 🔹 Zone Performance
          // ============================
          _buildZonePerformance(),
        ],
      ),
    );
  }

  // -------------------------------------------------------
  // 🔹 Filters
  // -------------------------------------------------------
  Widget _buildFilters() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildMunicipalityDropdown()),
                const SizedBox(width: 16),
                Expanded(child: _buildMaterialDropdown()),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildDatePicker()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMunicipalityDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedMunicipality,
      decoration: _inputDecoration("Municipality"),
      items: municipalities
          .map(
            (m) => DropdownMenuItem<String>(
          value: m,
          child: Text(m),
        ),
      )
          .toList(),
      onChanged: (value) => setState(() => selectedMunicipality = value),
    );
  }

  Widget _buildMaterialDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedMaterial,
      decoration: _inputDecoration("Material Type"),
      items: materials
          .map(
            (m) => DropdownMenuItem<String>(
          value: m,
          child: Text(m),
        ),
      )
          .toList(),
      onChanged: (value) => setState(() => selectedMaterial = value),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(now.year - 3),
          lastDate: DateTime(now.year + 1),
        );
        if (picked != null) {
          setState(() => selectedDateRange = picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black26),
        ),
        child: Text(
          selectedDateRange == null
              ? "Select Date Range"
              : "${selectedDateRange!.start.toString().split(" ").first} → ${selectedDateRange!.end.toString().split(" ").first}",
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  // -------------------------------------------------------
  // 🔹 Stats Grid
  // -------------------------------------------------------
  Widget _buildStatsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 2.3,
      ),

      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];

        final Color color = stat['color'] as Color;
        final IconData icon = stat['icon'] as IconData;
        final String value = stat['value'] as String;
        final String label = stat['label'] as String;

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🔵 ICONO
                CircleAvatar(
                  radius: 16,
                  backgroundColor: color.withOpacity(.15),
                  child: Icon(icon, color: color, size: 18),
                ),

                const SizedBox(width: 12),

                // 🔹 CONTENIDO FLEXIBLE (Evita overflow)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 Valor
                      Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 2),

                      // 🔹 Label
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
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





  // -------------------------------------------------------
  // 🔹 Quick Actions
  // -------------------------------------------------------
  Widget _buildQuickActions() {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 900
        ? 4
        : width > 600
        ? 3
        : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: quickActions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 2.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, i) {
            final action = quickActions[i];
            final IconData icon = action['icon'] as IconData;
            final String label = action['label'] as String;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: mainColor.withOpacity(.1),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: mainColor),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // -------------------------------------------------------
  // 🔹 Top Collection Points
  // -------------------------------------------------------
  Widget _buildTopCollectionPoints() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Top Collection Points",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...topCollectionPoints.map((p) {
          final String name = p['name'] as String;
          final int collections = p['collections'] as int;
          final String status = p['status'] as String;

          final Color statusColor =
          status == "ACTIVE" ? Colors.green : Colors.orange;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: mainColor.withOpacity(.2),
                child: const Icon(Icons.place, color: Colors.black87),
              ),
              title: Text(name),
              subtitle: Text("$collections collections"),
              trailing: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // -------------------------------------------------------
  // 🔹 Material Distribution
  // -------------------------------------------------------
  Widget _buildMaterialDistribution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Material Distribution",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...materialDistribution.map((m) {
          final String type = m['type'] as String;
          final int percentage = m['percentage'] as int;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(type, style: const TextStyle(fontSize: 16)),
                  Text("$percentage%"),
                ],
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: percentage / 100,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
                color: mainColor,
                backgroundColor: mainColor.withOpacity(.2),
              ),
              const SizedBox(height: 16),
            ],
          );
        }),
      ],
    );
  }

  // -------------------------------------------------------
  // 🔹 Zone Performance
  // -------------------------------------------------------
  Widget _buildZonePerformance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Zone Performance",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...zonePerformance.map((z) {
          final String zone = z['zone'] as String;
          final int collections = z['collections'] as int;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: mainColor.withOpacity(.15),
                child: const Icon(Icons.location_on, color: Colors.black),
              ),
              title: Text(zone),
              subtitle: Text("$collections collections"),
            ),
          );
        }),
      ],
    );
  }
}
