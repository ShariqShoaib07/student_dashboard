import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_design_system.dart';
import 'profile_edit_screen.dart';
import '../services/auth_service.dart';
import '../widgets/base_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLogoutTime = '30 minutes';

  final List<String> _logoutTimes = [
    '15 minutes',
    '30 minutes',
    '1 hour',
    'Never',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BaseScreen(
      title: 'Settings',
      body: ListView(
        padding: AppDesignSystem.defaultPadding,
        children: [
          // Notification Settings
          AppDesignSystem.card(
            context: context,
            child: SwitchListTile(
              title: Text(
                'Notifications',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Enable or disable app notifications',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 16),

          // Dark Mode Settings
          AppDesignSystem.card(
            context: context,
            child: SwitchListTile(
              title: Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Switch between light and dark theme',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 16),

          // Auto Logout Time
          AppDesignSystem.card(
            context: context,
            child: Padding(
              padding: AppDesignSystem.sectionPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Auto Logout Time',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedLogoutTime,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: AppDesignSystem.defaultBorderRadius,
                        borderSide: BorderSide(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    items:
                        _logoutTimes
                            .map(
                              (time) => DropdownMenuItem(
                                value: time,
                                child: Text(time),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLogoutTime = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Edit Profile
          AppDesignSystem.card(
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileEditScreen(),
                ),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Logout
          AppDesignSystem.card(
            context: context,
            onTap: _logout,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Logout'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      await AuthService().logout();
      // TODO: Navigate to login screen
      // Navigator.pushAndRemoveUntil(...)
    }
  }
}
