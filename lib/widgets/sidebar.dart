import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  final Function(String)? onItemSelected;
  final String currentItem;
  final String role;

  const AppSidebar({
    super.key,
    this.onItemSelected,
    required this.currentItem,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFF1FC7DB);

    return SizedBox(
      width: 260,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: mainColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.recycling, color: Colors.white, size: 36),
                  SizedBox(width: 10),
                  Text(
                    'Metalix',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // -----------------------------------
            // CITIZEN MENU
            // -----------------------------------
            if (role == "CITIZEN") ...[
              _buildItem(Icons.dashboard_outlined, 'Dashboard', context, mainColor),
              _buildItem(Icons.recycling_outlined, 'Waste Collections', context, mainColor),
              _buildItem(Icons.card_giftcard_outlined, 'Rewards', context, mainColor),

              // 👇 Aquí reemplazamos Settings → My Cards
              _buildItem(Icons.credit_card, 'My Cards', context, mainColor),

              const Divider(),
              _buildItem(Icons.account_circle_outlined, 'Profile', context, mainColor),
            ],

            // -----------------------------------
            // MUNICIPALITY ADMIN MENU
            // -----------------------------------
            if (role == "SYSTEM_ADMIN") ...[
              _buildItem(Icons.dashboard_outlined, 'Dashboard', context, mainColor),
              _buildItem(Icons.business_outlined, 'Municipality', context, mainColor),
              _buildItem(Icons.monitor_heart_outlined, 'Monitoring', context, mainColor),
              _buildItem(Icons.settings_outlined, 'Settings', context, mainColor),
              const Divider(),
              _buildItem(Icons.admin_panel_settings, 'Admin', context, mainColor),
            ],

            const Spacer(),

            // LOGOUT
            _buildItem(Icons.logout, 'Logout', context, mainColor, isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
      IconData icon,
      String title,
      BuildContext context,
      Color color, {
        bool isLogout = false,
      }) {
    final bool isSelected = currentItem == title;

    return ListTile(
      leading: Icon(
        icon,
        color: isLogout
            ? Colors.red
            : isSelected
            ? color
            : Colors.grey[700],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout
              ? Colors.red
              : isSelected
              ? color
              : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      tileColor: isSelected ? color.withOpacity(0.1) : null,
      onTap: () => onItemSelected?.call(title),
    );
  }
}
