import 'dart:async';

class NotificationService {
  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // Notification counts storage
  final Map<String, int> _notificationCounts = {
    'home': 0,
    'attendance': 0,
    'assessment': 0,
    'chat': 0,
    'settings': 0,
  };

  // Stream controller for notifications
  final _notificationController =
      StreamController<Map<String, int>>.broadcast();
  Stream<Map<String, int>> get notificationStream =>
      _notificationController.stream;

  // Add notifications
  void addNotification(String type, {int count = 1}) {
    if (_notificationCounts.containsKey(type)) {
      _notificationCounts[type] = _notificationCounts[type]! + count;
      _notificationController.add(_notificationCounts);
    }
  }

  // Clear notifications
  void clearNotifications(String type) {
    if (_notificationCounts.containsKey(type)) {
      _notificationCounts[type] = 0;
      _notificationController.add(_notificationCounts);
    }
  }

  // Get current count
  int getCount(String type) {
    return _notificationCounts[type] ?? 0;
  }

  void dispose() {
    _notificationController.close();
  }
}
