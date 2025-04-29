// lib/screens/assessments_screen.dart
import 'package:flutter/material.dart';
import '../utils/app_design_system.dart';
import '../utils/theme.dart';

class AssessmentsScreen extends StatelessWidget {
  const AssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDesignSystem.appBar(context, 'Assessments'),
      body: ListView(
        padding: AppDesignSystem.defaultPadding,
        children: [
          _buildAssessmentCard(
            title: 'Monthly Tests',
            icon: Icons.assignment,
            color: AppColors.accentBlue,
            context: context,
          ),
          const SizedBox(height: 16),
          _buildAssessmentCard(
            title: 'Send Up Exams',
            icon: Icons.school,
            color: AppColors.primary,
            context: context,
          ),
          const SizedBox(height: 16),
          _buildAssessmentCard(
            title: 'Half Book Exams',
            icon: Icons.book,
            color: AppColors.secondary,
            context: context,
          ),
          const SizedBox(height: 16),
          _buildAssessmentCard(
            title: 'Test Session',
            icon: Icons.quiz,
            color: AppColors.accentAmber,
            context: context,
          ),
          const SizedBox(height: 16),
          _buildAssessmentCard(
            title: 'Full Book Exams',
            icon: Icons.library_books,
            color: AppColors.accentPink,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentCard({
    required String title,
    required IconData icon,
    required Color color,
    required BuildContext context,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Handle card tap
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.7)),
            ],
          ),
        ),
      ),
    );
  }
}
