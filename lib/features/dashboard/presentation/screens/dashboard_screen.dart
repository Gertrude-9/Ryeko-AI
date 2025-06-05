import 'package:flutter/material.dart';
import 'package:ryeko_ai/features/auth/presentation/screens/edit_profile_screen.dart';
import 'ai_predictions_screen.dart';
import 'data_collection_screen.dart';
import 'data_visualization_screen.dart';
import 'decision_support_screen.dart';
import 'help_support_sheet.dart';
import 'home_screen.dart';
import 'notifications_screen.dart';
// <- Import edit profile screen

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const DataCollectionScreen(),
    const AIPredictionsScreen(),
    const DecisionSupportScreen(),
    const DataVisualizationScreen(),
  ];

  final List<String> _titles = [
    'Home Page',
    'Data Collection',
    'AI Predictions',
    'Decision Support',
    'Data Visualization & Reports',
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.agriculture),
      label: 'Data',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.auto_awesome),
      label: 'AI',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assistant),
      label: 'Support',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.analytics),
      label: 'Reports',
    ),
  ];

  void _openNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsScreen()),
    );
  }

  void _openHelp() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const HelpSupportSheet(),
    );
  }

  void _openEditProfile() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const EditProfileScreen(
        currentName: 'John Doe',
        currentEmail: 'john@example.com',
        currentPhone: '+123456789',
        currentUserType: 'Farmer',
        currentFarmName: 'Green Acres',
        currentFarmSize: 15.5,
        currentLocation: 'Nairobi',
        currentSoilType: 'Loamy',
        currentCrops: ['Maize', 'Wheat'],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _openEditProfile,
          ),
          _NotificationIcon(onPressed: _openNotifications),
          const SizedBox(width: 8),
          _HelpIcon(onPressed: _openHelp),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: (index) => setState(() => _currentIndex = index),
      items: _navItems,
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const _NotificationIcon({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: onPressed,
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            child: const Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _HelpIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const _HelpIcon({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help_outline),
      onPressed: onPressed,
    );
  }
}
