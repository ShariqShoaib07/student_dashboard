// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../utils/app_design_system.dart';
import 'attendance_screen.dart';
import 'assessments_screen.dart';
import 'chat_rooms_screen.dart';
import 'settings_screen.dart';
import 'home_screen_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2; // Home center
  final NotificationService _notificationService = NotificationService();

  final List<Widget> _pages = [
    AttendanceScreen(),
    AssessmentsScreen(),
    const HomeScreenContent(), // Your main dashboard
    ChatRoomsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: StreamBuilder<Map<String, int>>(
        stream: _notificationService.notificationStream,
        initialData: const {
          'attendance': 0,
          'assessment': 0,
          'chat': 0,
          'settings': 0,
        },
        builder: (context, snapshot) {
          return AppDesignSystem.fancyBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              // Clear notifications when tapping a tab
              if (index == 0)
                _notificationService.clearNotifications('attendance');
              if (index == 1)
                _notificationService.clearNotifications('assessment');
              if (index == 3) _notificationService.clearNotifications('chat');
              if (index == 4)
                _notificationService.clearNotifications('settings');

              setState(() {
                _currentIndex = index;
              });
            },
            context: context,
            notificationCounts: snapshot.data!,
          );
        },
      ),
    );
  }
}
