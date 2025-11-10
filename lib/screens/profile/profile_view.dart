import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final Color mainColor = const Color(0xFF1FC7DB);

  bool isEditing = false;
  bool isLoading = false;

  Map<String, dynamic> profileData = {
    'firstName': 'Usuario',
    'lastName': 'Test',
    'role': 'citizen',
    'memberSince': 'March 2024',
  };

  void saveProfile() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isEditing = false;
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile updated successfully!'),
        backgroundColor: mainColor,
      ),
    );
  }

  void cancelEdit() => setState(() => isEditing = false);
  void editProfile() => setState(() => isEditing = true);

  String getUserRoleDisplay() {
    switch (profileData['role']) {
      case 'admin':
        return 'Administrator';
      case 'citizen':
        return 'Citizen User';
      default:
        return 'Member';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 1,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: const TabBar(
              indicatorColor: Color(0xFF1FC7DB),
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.black54,
              tabs: [
                Tab(icon: Icon(Icons.info_outline), text: 'Overview'),
                Tab(icon: Icon(Icons.person), text: 'Personal Information'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildOverviewTab(),
            _buildPersonalInfoTab(),
          ],
        ),
      ),
    );
  }

  // 🔹 TAB 1 - Overview (perfil y estadísticas)
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 24),
          _buildProfileDetails(),
        ],
      ),
    );
  }

  // 🔹 TAB 2 - Personal Information
  Widget _buildPersonalInfoTab() {
    final fields = [
      {'label': 'First Name', 'key': 'firstName', 'readonly': false},
      {'label': 'Last Name', 'key': 'lastName', 'readonly': false},
      {'label': 'Email', 'key': 'email', 'readonly': true},
      {'label': 'Phone', 'key': 'phone', 'readonly': false},
      {'label': 'Address', 'key': 'address', 'readonly': false},
      {'label': 'City', 'key': 'city', 'readonly': false},
      {'label': 'ZIP Code', 'key': 'zipCode', 'readonly': false},
      {'label': 'Municipality', 'key': 'municipality', 'readonly': false},
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Personal Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isEditing ? Icons.save : Icons.edit,
                      color: mainColor,
                    ),
                    onPressed: () {
                      setState(() => isEditing = !isEditing);
                      if (!isEditing) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                            const Text('Changes saved successfully!'),
                            backgroundColor: mainColor,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Campos del formulario
              Wrap(
                runSpacing: 16,
                spacing: 16,
                children: fields.map((field) {
                  return _buildTextField(
                    label: field['label'] as String,
                    keyName: field['key'] as String,
                    readOnly: field['readonly'] as bool,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String keyName,
    bool readOnly = false,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width > 600
          ? (MediaQuery.of(context).size.width / 2) - 40
          : double.infinity,
      child: TextField(
        controller: TextEditingController(
          text: profileData[keyName] ?? '',
        ),
        readOnly: readOnly || !isEditing,
        onChanged: (value) => profileData[keyName] = value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  // 🔹 Header con avatar, nombre y acciones
  Widget _buildProfileHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            return Flex(
              direction: isWide ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: mainColor.withOpacity(0.1),
                      child: const Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                        size: 70,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${profileData['firstName']} ${profileData['lastName']}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          getUserRoleDisplay(),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Member since ${profileData['memberSince']}',
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                isEditing ? _buildEditActions() : _buildEditButton(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.edit, color: Colors.white),
      label: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: isLoading ? null : editProfile,
    );
  }

  Widget _buildEditActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          icon: isLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : const Icon(Icons.save, color: Colors.white),
          label: Text(
            isLoading ? 'Saving...' : 'Save Changes',
            style: const TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onPressed: isLoading ? null : saveProfile,
        ),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          icon: const Icon(Icons.cancel, color: Colors.black87),
          label: const Text('Cancel'),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.black26),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onPressed: isLoading ? null : cancelEdit,
        ),
      ],
    );
  }

  // 🔹 Info del perfil + estadísticas (Overview tab)
  Widget _buildProfileDetails() {
    final fields = [
      {'label': 'Email', 'value': 'test@example.com'},
      {'label': 'Phone', 'value': '+51 987 654 321'},
      {'label': 'Region', 'value': 'Lima, Peru'},
      {'label': 'Account Type', 'value': 'Citizen'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Divider(height: 24),
                ...fields.map((field) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          field['label']!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          field['value']!,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        if (profileData['role'] == 'citizen') _buildCitizenStats(),
      ],
    );
  }

  Widget _buildCitizenStats() {
    final stats = [
      {
        'icon': Icons.stars,
        'color': const Color(0xFF1FC7DB),
        'value': '8,250',
        'label': 'Total Points',
      },
      {
        'icon': Icons.recycling,
        'color': Colors.green,
        'value': '1,050 kg',
        'label': 'Waste Collected',
      },
      {
        'icon': Icons.card_giftcard,
        'color': Colors.orange,
        'value': '12',
        'label': 'Rewards Earned',
      },
    ];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Citizen Statistics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(height: 24),
            Column(
              children: stats.map((stat) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor:
                      (stat['color'] as Color).withOpacity(0.15),
                      child: Icon(stat['icon'] as IconData,
                          color: stat['color'] as Color, size: 26),
                    ),
                    title: Text(
                      stat['value'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      stat['label'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
