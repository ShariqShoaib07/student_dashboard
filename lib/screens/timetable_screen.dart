// lib/screens/timetable_screen.dart
import 'package:flutter/material.dart';
import '../utils/app_design_system.dart';
import '../utils/theme.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDesignSystem.appBar(context, 'Class Schedule'),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // This would come from your data source in a real app
                  final days = [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                  ];
                  final day = days[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                _buildClassItem(
                                  context,
                                  time: '08:00 - 09:00',
                                  subject: 'Mathematics',
                                  room: 'B-12',
                                  color: AppColors.primary,
                                ),
                                const Divider(height: 16, thickness: 1),
                                _buildClassItem(
                                  context,
                                  time: '09:00 - 10:00',
                                  subject: 'Physics',
                                  room: 'Lab-2',
                                  color: AppColors.secondary,
                                ),
                                const Divider(height: 16, thickness: 1),
                                _buildClassItem(
                                  context,
                                  time: '10:30 - 11:30',
                                  subject: 'Chemistry',
                                  room: 'B-14',
                                  color: AppColors.accentBlue,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 5, // 5 days
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassItem(
    BuildContext context, {
    required String time,
    required String subject,
    required String room,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  subject,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(room, style: TextStyle(color: color)),
          ),
        ],
      ),
    );
  }
}
