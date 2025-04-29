// lib/screens/chat_rooms_screen.dart
import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';
import '../utils/app_design_system.dart';
import '../widgets/base_screen.dart';
import '../utils/theme.dart';

class ChatRoomsScreen extends StatefulWidget {
  const ChatRoomsScreen({super.key});

  @override
  State<ChatRoomsScreen> createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  final List<Map<String, dynamic>> chatRooms = [
    {
      'id': 'general',
      'name': 'General Chat',
      'subject': 'General',
      'unreadCount': 3,
      'lastMessage': 'Hello everyone!',
      'isGeneral': true,
    },
    {
      'id': 'math',
      'name': 'Mathematics',
      'subject': 'Math',
      'unreadCount': 0,
      'lastMessage': 'Did you solve problem 5?',
      'isGeneral': false,
    },
    {
      'id': 'science',
      'name': 'Science',
      'subject': 'Science',
      'unreadCount': 5,
      'lastMessage': 'Lab results are in!',
      'isGeneral': false,
    },
    {
      'id': 'history',
      'name': 'History',
      'subject': 'History',
      'unreadCount': 0,
      'lastMessage': 'Don\'t forget the essay',
      'isGeneral': false,
    },
    {
      'id': 'english',
      'name': 'English',
      'subject': 'English',
      'unreadCount': 1,
      'lastMessage': 'Read chapter 4 for next class',
      'isGeneral': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Chat Rooms',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDesignSystem.sectionHeader(context, 'General Chat'),
            Padding(
              padding: AppDesignSystem.sectionPadding,
              child: _buildGeneralChatCard(context),
            ),
            AppDesignSystem.sectionHeader(context, 'Subject Chats'),
            Padding(
              padding: AppDesignSystem.sectionPadding,
              child: Column(
                children:
                    chatRooms
                        .where((room) => !room['isGeneral'])
                        .map((room) => _buildSubjectChatCard(context, room))
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralChatCard(BuildContext context) {
    final generalRoom = chatRooms.firstWhere((room) => room['isGeneral']);
    return AppDesignSystem.card(
      context: context,
      onTap: () => _navigateToChatScreen(context, generalRoom),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.people, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  generalRoom['name'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  generalRoom['lastMessage'],
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (generalRoom['unreadCount'] > 0)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.accentPink,
                shape: BoxShape.circle,
              ),
              child: Text(
                generalRoom['unreadCount'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSubjectChatCard(
    BuildContext context,
    Map<String, dynamic> room,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AppDesignSystem.card(
        context: context,
        onTap: () => _navigateToChatScreen(context, room),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getSubjectColor(room['subject']),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                room['subject'][0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room['name'],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    room['lastMessage'],
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (room['unreadCount'] > 0)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.accentPink,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  room['unreadCount'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getSubjectColor(String subject) {
    final colors = {
      'Math': AppColors.secondary,
      'Science': AppColors.accentBlue,
      'History': AppColors.accentAmber,
      'English': AppColors.primaryLight,
    };
    return colors[subject] ?? AppColors.primary;
  }

  void _navigateToChatScreen(BuildContext context, Map<String, dynamic> room) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                ChatScreen(roomId: room['id'], roomName: room['name']),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }
}
