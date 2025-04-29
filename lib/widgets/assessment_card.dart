// lib/widgets/assessment_card.dart
import 'package:flutter/material.dart';
import '../utils/app_design_system.dart';
import '../utils/theme.dart';

class AssessmentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const AssessmentCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppDesignSystem.card(
      context: context,
      onTap: () => _navigateToAssessmentDetails(context, title),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color.withOpacity(0.1),
                foregroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _navigateToAssessmentDetails(context, title),
              child: const Text('View Details'),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAssessmentDetails(BuildContext context, String title) {
    // TODO: Implement navigation to detailed assessment list
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Viewing details for $title')));
  }
}
