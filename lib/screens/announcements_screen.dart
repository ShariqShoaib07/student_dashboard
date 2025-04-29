// lib/screens/announcements_screen.dart
import 'package:flutter/material.dart';
import '../models/announcement_model.dart';
import '../utils/app_design_system.dart';
import '../utils/theme.dart';

class AnnouncementsScreen extends StatelessWidget {
  final List<Announcement> announcements = [
    Announcement(
      id: '1',
      title: 'Sports Day Postponed',
      message:
          'The sports day event has been postponed to next week due to weather conditions. Please check the new schedule in the notice board.',
      date: DateTime.now(),
      author: 'Sports Committee',
    ),
    Announcement(
      id: '2',
      title: 'Science Fair Winners',
      message:
          'Congratulations to all participants of the annual science fair. The winners will be announced in the assembly tomorrow.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      author: 'Science Department',
    ),
    Announcement(
      id: '3',
      title: 'Library Closure',
      message:
          'The school library will be closed this Friday for maintenance work. It will reopen on Monday.',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Announcement(
      id: '4',
      title: 'Parent-Teacher Meeting',
      message:
          'The next parent-teacher meeting is scheduled for 15th of this month. Please confirm your attendance.',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Announcement(
      id: '5',
      title: 'Exam Schedule',
      message:
          'The final exam schedule has been posted on the notice board. Please check your subjects and timings.',
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDesignSystem.appBar(context, 'Announcements'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          final announcement = announcements[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.grey[200], // Set a light, attractive background color
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        announcement.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        announcement.timeAgo,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  if (announcement.author != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'By ${announcement.author}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    announcement.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
