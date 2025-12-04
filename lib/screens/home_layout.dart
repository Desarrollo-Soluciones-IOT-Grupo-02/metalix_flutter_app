import 'package:flutter/material.dart';
import 'package:metalixmovil/models/user_model.dart';
import 'package:metalixmovil/screens/profile/profile_view.dart';
import 'package:metalixmovil/screens/rewards/rewards_view.dart';
import '../widgets/sidebar.dart';
import 'dashboard/citizen_dashboard_view.dart';
import 'dashboard/admin_dashboard_view.dart';
import 'dashboard/waste_collection_view.dart';
import 'dashboard/municipality_view.dart';
import 'package:metalixmovil/screens/cards/my_cards_view.dart';
import 'dashboard/monitoring_view.dart';

class DashboardScreen extends StatefulWidget {
  final UserModel user; // Usuario logueado

  const DashboardScreen({super.key, required this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedMenu = 'Dashboard';
  late String role;

  @override
  void initState() {
    super.initState();
    role = widget.user.role; // CITIZEN o SYSTEM_ADMIN
  }

  // ===============================
  //       MANEJO DEL MENÚ
  // ===============================
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

  // ===============================
  //            UI BASE
  // ===============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppSidebar(
        currentItem: selectedMenu,
        onItemSelected: onMenuSelect,
        role: role, // 👈 Sidebar renderiza según rol
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(
          selectedMenu,
          style: const TextStyle(color: Colors.black87),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                role == "SYSTEM_ADMIN"
                    ? "Welcome, Admin!"
                    : "Welcome!",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFF4F6F8),
      body: _buildContent(),
    );
  }

  // ============================================================
  //               CONTENIDO SEGÚN ROL Y OPCIÓN
  // ============================================================
  Widget _buildContent() {
    // -----------------------------------
    //        MUNICIPALITY ADMIN
    // -----------------------------------
    if (role == "SYSTEM_ADMIN") {
      switch (selectedMenu) {
        case 'Dashboard':
          return const AdminDashboardView();

        case 'Municipality':
          return const MunicipalityView();

        case 'Monitoring':
          return const MonitoringView();

        case 'Settings':
          return const Center(
              child: Text("Admin Settings View",
                  style: TextStyle(fontSize: 22)));

        case 'Admin':
          return const Center(
              child: Text("Admin Profile View",
                  style: TextStyle(fontSize: 22)));

        default:
          return const Center(child: Text("Select an option"));
      }
    }

    // -----------------------------------
    //                CITIZEN
    // -----------------------------------
    switch (selectedMenu) {
      case 'Dashboard':
        return const CitizenDashboardView();

      case 'Waste Collections':
        return const WasteCollectionView();

      case 'Rewards':
        return const RewardsView();

      case 'My Cards':
        return MyCardsView(
          userId: int.parse(widget.user.id), // convierte el string 'id' a int
        );

      case 'Profile':
        return ProfileView(
          userId: int.parse(widget.user.id),
          token: widget.user.token,
        );

      default:
        return const Center(child: Text('Select an option'));
    }
  }
}
