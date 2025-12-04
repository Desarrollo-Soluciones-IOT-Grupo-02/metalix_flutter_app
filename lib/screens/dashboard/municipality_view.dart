import 'package:flutter/material.dart';

class MunicipalityView extends StatefulWidget {
  const MunicipalityView({super.key});

  @override
  State<MunicipalityView> createState() => _MunicipalityViewState();
}

class _MunicipalityViewState extends State<MunicipalityView> {
  final Color mainColor = const Color(0xFF1FC7DB);

  bool showDetails = false;
  Map<String, dynamic>? selectedMunicipality;

  // ----------------------------------------------------------------------
  // 🔹 FAKE MUNICIPALITIES
  // ----------------------------------------------------------------------
  final List<Map<String, dynamic>> municipalities = [
    {
      "id": 1,
      "name": "Municipality A",
      "status": "Active",
      "region": "Zona 1",
      "code": "MN-001",
      "population": 12500,
      "totalCitizens": 3400,
      "collectionPoints": 8,
      "activeRewards": 12,
      "totalWasteCollected": 1850,
    },
    {
      "id": 2,
      "name": "Municipality B",
      "status": "Active",
      "region": "Zona 2",
      "code": "MN-002",
      "population": 9800,
      "totalCitizens": 2400,
      "collectionPoints": 5,
      "activeRewards": 8,
      "totalWasteCollected": 990,
    },
  ];

  // ----------------------------------------------------------------------
  // 🔹 FAKE COLLECTION POINTS
  // ----------------------------------------------------------------------
  final List<Map<String, dynamic>> collectionPoints = [
    {
      "id": 1,
      "name": "Point A",
      "address": "Main Square",
      "capacity": "High",
      "status": "ACTIVE",
      "lastMaintenance": "2025-01-10",
      "totalCollections": 210,
      "deviceId": "DEV-001"
    },
    {
      "id": 2,
      "name": "Point B",
      "address": "Industrial Zone",
      "capacity": "Medium",
      "status": "MAINTENANCE",
      "lastMaintenance": "2024-12-02",
      "totalCollections": 155,
      "deviceId": "DEV-002"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return showDetails ? _buildMunicipalityDetails() : _buildMunicipalityList();
  }

  // ----------------------------------------------------------------------
  // 📌 VISTA 1: LISTA DE MUNICIPALIDADES
  // ----------------------------------------------------------------------
  Widget _buildMunicipalityList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("All Municipalities",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const Text("Select a municipality to manage its details",
              style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),

          // Grid (1 por fila para responsive mobile)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: municipalities.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final m = municipalities[index];

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedMunicipality = m;
                      showDetails = true;
                    });
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: mainColor.withOpacity(.15),
                          child: const Icon(Icons.location_city,
                              color: Colors.black),
                        ),
                        const SizedBox(width: 16),

                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(m["name"],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text("Region: ${m["region"]}"),
                              Text("Code: ${m["code"]}"),
                              Text("Population: ${m["population"]}"),
                            ],
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Chip(
                              label: Text(m["status"]),
                              backgroundColor: mainColor.withOpacity(.15),
                              labelStyle: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.place, size: 18),
                                Text(" ${m["collectionPoints"]} pts"),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------------
  // 📌 VISTA 2: DETALLE MUNICIPALIDAD
  // ----------------------------------------------------------------------
  Widget _buildMunicipalityDetails() {
    final m = selectedMunicipality!;

    return DefaultTabController(
      length: 3,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            TextButton.icon(
              onPressed: () => setState(() => showDetails = false),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Back to Municipalities"),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: mainColor.withOpacity(.2),
                  child: const Icon(Icons.location_city, size: 28),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m["name"],
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const Text("Managing collection points & citizens",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: "Collection Points"),
                Tab(text: "Citizens"),
                Tab(text: "Rewards"),
              ],
            ),

            SizedBox(
              height: 650,
              child: TabBarView(
                children: [
                  _buildCollectionPointsTab(),
                  _buildCitizensTab(),
                  _buildRewardsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------------------
  // 📌 TAB 1: COLLECTION POINTS + BOTÓN + MODAL
  // ----------------------------------------------------------------------
  Widget _buildCollectionPointsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: openAddCollectionPointModal,
            icon: const Icon(Icons.add_location_alt),
            label: const Text("Add Collection Point"),
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Expanded(
          child: ListView.builder(
            itemCount: collectionPoints.length,
            itemBuilder: (context, index) {
              final p = collectionPoints[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: mainColor.withOpacity(.15),
                    child: const Icon(Icons.place, color: Colors.black),
                  ),
                  title: Text(p["name"]),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address: ${p["address"]}"),
                      Text("Capacity: ${p["capacity"]}"),
                      Text("Status: ${p["status"]}"),
                      Text("Device ID: ${p["deviceId"] ?? '—'}"),
                      Text("Collections: ${p["totalCollections"]}"),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------------------
  // 📌 TAB 2: FAKE
  // ----------------------------------------------------------------------
  Widget _buildCitizensTab() {
    return const Center(
      child: Text("Fake Citizens Table Coming Soon"),
    );
  }

  // ----------------------------------------------------------------------
  // 📌 TAB 3: FAKE
  // ----------------------------------------------------------------------
  Widget _buildRewardsTab() {
    return const Center(
      child: Text("Rewards Management Coming Soon"),
    );
  }

  // ----------------------------------------------------------------------
  // 📌 MODAL PARA CREAR COLLECTION POINT
  // ----------------------------------------------------------------------
  void openAddCollectionPointModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final TextEditingController nameCtrl = TextEditingController();
            final TextEditingController addrCtrl = TextEditingController();
            final TextEditingController capCtrl =
            TextEditingController(text: "100");
            final TextEditingController latCtrl =
            TextEditingController(text: "-12.11");
            final TextEditingController lngCtrl =
            TextEditingController(text: "-77.03");
            final TextEditingController deviceCtrl = TextEditingController();

            String status = "Active";
            String zone = "Zona Centro";

            bool nameError = false;

            final List<String> statuses = [
              "Active",
              "Inactive",
              "Maintenance"
            ];
            final List<String> zones = [
              "Zona Norte",
              "Zona Sur",
              "Zona Centro"
            ];

            return Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.add_location_alt, color: mainColor),
                        const SizedBox(width: 8),
                        const Text(
                          "Add Collection Point",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    _modalInput(
                      label: "Name",
                      icon: Icons.place,
                      controller: nameCtrl,
                      errorText: nameError ? "Name is required" : null,
                    ),
                    const SizedBox(height: 16),

                    _modalInput(
                      label: "Address",
                      icon: Icons.home,
                      controller: addrCtrl,
                    ),
                    const SizedBox(height: 16),

                    _modalInput(
                      label: "Capacity",
                      icon: Icons.scale,
                      controller: capCtrl,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    _modalDropdown(
                      label: "Status",
                      value: status,
                      icon: Icons.check_circle,
                      items: statuses,
                      onChanged: (v) =>
                          setModalState(() => status = v!),
                    ),
                    const SizedBox(height: 16),

                    _modalDropdown(
                      label: "Zone",
                      value: zone,
                      icon: Icons.location_city,
                      items: zones,
                      onChanged: (v) =>
                          setModalState(() => zone = v!),
                    ),
                    const SizedBox(height: 16),

                    _modalInput(
                      label: "Latitude",
                      icon: Icons.my_location,
                      controller: latCtrl,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    _modalInput(
                      label: "Longitude",
                      icon: Icons.location_on,
                      controller: lngCtrl,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    _modalInput(
                      label: "Device ID",
                      icon: Icons.qr_code,
                      controller: deviceCtrl,
                    ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 12),

                        ElevatedButton.icon(
                          onPressed: () {
                            setModalState(() {
                              nameError =
                                  nameCtrl.text.trim().isEmpty;
                            });

                            if (nameError) return;

                            setState(() {
                              collectionPoints.add({
                                "id": collectionPoints.length + 1,
                                "name": nameCtrl.text.trim(),
                                "address": addrCtrl.text.trim(),
                                "capacity": capCtrl.text.trim(),
                                "status": status,
                                "zone": zone,
                                "lat": latCtrl.text.trim(),
                                "lng": lngCtrl.text.trim(),
                                "deviceId": deviceCtrl.text.trim(),
                                "totalCollections": 0,
                                "lastMaintenance": "—",
                              });
                            });

                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Add Collection Point"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ----------------------------------------------------------------------
  // 📌 SUBWIDGETS DEL MODAL
  // ----------------------------------------------------------------------

  Widget _modalInput({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: mainColor),
            errorText: errorText,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _modalDropdown({
    required String label,
    required String value,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(14),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
