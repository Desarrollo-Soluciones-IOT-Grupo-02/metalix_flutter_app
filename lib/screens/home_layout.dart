import 'package:flutter/material.dart';
import 'package:metalixmovil/screens/profile/profile_view.dart';
import 'package:metalixmovil/screens/rewards/rewards_view.dart';
import '../widgets/sidebar.dart';
import 'dashboard/citizen_dashboard_view.dart';
import 'dashboard/waste_collection_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Color mainColor = const Color(0xFF1FC7DB);

  String selectedMenu = 'Dashboard';

  void onMenuSelect(String item) {
    Navigator.pop(context);

    if (item == 'Logout') {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    setState(() {
      selectedMenu = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppSidebar(
        currentItem: selectedMenu,
        onItemSelected: onMenuSelect,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(selectedMenu, style: const TextStyle(color: Colors.black87)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Welcome!',
                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFF4F6F8),
      body: _buildContent(),
    );
  }
  Widget _buildContent() {
    switch (selectedMenu) {
      case 'Dashboard':
        return const CitizenDashboardView();
      case 'Waste Collections':
        return const WasteCollectionView();
      case 'Rewards':
        return const RewardsView();
      case 'Settings':
        return const Center(child: Text('Settings view coming soon...'));
      case 'Profile':
        return const ProfileView();
      default:
        return const Center(child: Text('Select an option from the sidebar'));
    }
  }


}
