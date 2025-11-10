import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  final Function(String)? onItemSelected;
  final String currentItem;

  const AppSidebar({
    super.key,
    this.onItemSelected,
    required this.currentItem,
  });

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFF1FC7DB);

    return SizedBox(
      width: 260,
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: mainColor),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.recycling, color: Colors.white, size: 36),
                    SizedBox(width: 10),
                    Text(
                      'Metalix',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔹 Opciones principales
            _buildItem(Icons.dashboard_outlined, 'Dashboard', context, mainColor),
            _buildItem(Icons.recycling_outlined, 'Waste Collections', context, mainColor),
            _buildItem(Icons.card_giftcard_outlined, 'Rewards', context, mainColor),
            _buildItem(Icons.settings_outlined, 'Settings', context, mainColor),

            const Divider(),

            // 🔹 Opciones inferiores
            _buildItem(Icons.account_circle_outlined, 'Profile', context, mainColor),
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
            ? Colors.redAccent
            : isSelected
            ? color
            : Colors.grey[700],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout
              ? Colors.redAccent
              : isSelected
              ? color
              : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      tileColor: isSelected
          ? color.withOpacity(0.1)
          : Colors.transparent, // 👈 fondo suave para la opción activa
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () => onItemSelected?.call(title),
    );
  }
}
