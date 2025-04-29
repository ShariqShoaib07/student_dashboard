import 'package:flutter/material.dart';
import 'badge_helper.dart';
import '../services/notification_service.dart';

class AppDesignSystem {
  // App-wide padding constants
  static const EdgeInsets defaultPadding = EdgeInsets.all(16);
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  // App-wide border radius
  static const BorderRadius defaultBorderRadius = BorderRadius.all(
    Radius.circular(16),
  );
  static const BorderRadius messageBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
    bottomLeft: Radius.circular(4),
    bottomRight: Radius.circular(16),
  );

  // App-wide durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  // App Bar Style
  static AppBar appBar(
    BuildContext context,
    String title, {
    List<Widget>? actions,
  }) {
    return AppBar(
      title: Text(title),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      actions: actions,
    );
  }

  // Card Style
  static Card card({
    required BuildContext context,
    required Widget child,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      color: Theme.of(context).cardTheme.color,
      child: InkWell(
        borderRadius: defaultBorderRadius,
        onTap: onTap,
        child: Padding(padding: cardPadding, child: child),
      ),
    );
  }

  // Gradient Background
  static BoxDecoration gradientBackground(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).colorScheme.primary.withOpacity(0.1),
          Theme.of(context).colorScheme.background,
        ],
      ),
    );
  }

  // Section Header
  static Widget sectionHeader(
    BuildContext context,
    String title, {
    String? actionText,
    VoidCallback? onAction,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          if (actionText != null)
            TextButton(
              onPressed: onAction,
              child: Text(
                actionText,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
        ],
      ),
    );
  }

  // Stat Card
  static Widget statCard({
    required BuildContext context,
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: defaultBorderRadius,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Message Input Field
  static Widget messageInput({
    required BuildContext context,
    required TextEditingController controller,
    required FocusNode focusNode,
    required VoidCallback onSend,
    VoidCallback? onAttach,
  }) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
            onPressed: onAttach,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: onSend,
            ),
          ),
        ],
      ),
    );
  }

  static Widget fancyBottomNavigationBar({
    required int currentIndex,
    required ValueChanged<int> onTap,
    required BuildContext context,
    Map<String, int>? notificationCounts,
  }) {
    final counts =
        notificationCounts ??
        {'attendance': 0, 'assessment': 0, 'chat': 0, 'settings': 0};

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: Stack(
        children: [
          // Main navigation items
          Row(
            children: [
              // Left side items
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        context: context,
                        icon: Icons.calendar_today_outlined,
                        label: 'Attendance',
                        isSelected: currentIndex == 0,
                        onTap: () {
                          NotificationService().clearNotifications(
                            'attendance',
                          );
                          onTap(0);
                        },
                        badgeCount: counts['attendance'] ?? 0,
                      ),
                      _buildNavItem(
                        context: context,
                        icon: Icons.assessment_outlined,
                        label: 'Assessment',
                        isSelected: currentIndex == 1,
                        onTap: () {
                          NotificationService().clearNotifications(
                            'assessment',
                          );
                          onTap(1);
                        },
                        badgeCount: counts['assessment'] ?? 0,
                      ),
                    ],
                  ),
                ),
              ),

              // Right side items
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        context: context,
                        icon: Icons.chat_outlined,
                        label: 'Chat',
                        isSelected: currentIndex == 3,
                        onTap: () {
                          NotificationService().clearNotifications('chat');
                          onTap(3);
                        },
                        badgeCount: counts['chat'] ?? 0,
                      ),
                      _buildNavItem(
                        context: context,
                        icon: Icons.settings,
                        label: 'Settings',
                        isSelected: currentIndex == 4,
                        onTap: () {
                          NotificationService().clearNotifications('settings');
                          onTap(4);
                        },
                        badgeCount: counts['settings'] ?? 0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Center button
          Center(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: GestureDetector(
                onTap: () => onTap(2),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color:
                        currentIndex == 2
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color:
                          currentIndex == 2
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    currentIndex == 2 ? Icons.home : Icons.home_outlined,
                    color:
                        currentIndex == 2
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    int badgeCount = 0,
  }) {
    Widget iconWidget = Icon(
      icon,
      size: 22,
      color:
          isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).textTheme.bodyMedium?.color,
    );

    if (badgeCount > 0) {
      iconWidget = BadgeHelper.buildBadge(
        child: iconWidget,
        count: badgeCount,
        color: Theme.of(context).colorScheme.error,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          constraints: const BoxConstraints(minWidth: 56),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconWidget,
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
