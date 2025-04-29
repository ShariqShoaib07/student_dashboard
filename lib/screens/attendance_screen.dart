import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../widgets/attendance_progress_bar.dart';
import '../screens/attendance_records_screen.dart';
import '../models/attendance_model.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Map<String, dynamic>> subjects = [
    {'name': 'Mathematics', 'percentage': 92, 'icon': Icons.calculate},
    {'name': 'Physics', 'percentage': 78, 'icon': Icons.science},
    {'name': 'Chemistry', 'percentage': 58, 'icon': Icons.emoji_objects},
    {'name': 'English', 'percentage': 88, 'icon': Icons.menu_book},
    {'name': 'Computer Science', 'percentage': 45, 'icon': Icons.computer},
  ];

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // In real app, fetch latest attendance here
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final overallAttendance = _calculateOverallAttendance();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary.withOpacity(0.1), AppColors.background],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: CustomScrollView(
            slivers: [
              // Summary Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildSummaryCard(context, overallAttendance),
                ),
              ),

              // Subjects Header
              SliverPadding(
                padding: const EdgeInsets.only(left: 24, top: 16, right: 24),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Subject-wise Attendance',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Subjects List
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final subject = subjects[index];
                    return _buildSubjectCard(context, subject);
                  }, childCount: subjects.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, int overallPercentage) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryLight, AppColors.accentBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bar_chart,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Overall Attendance',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '$overallPercentage%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AttendanceProgressBar(percentage: overallPercentage),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => AttendanceRecordsScreen(
                            summary: AttendanceSummary(
                              overallPercentage: overallPercentage,
                              totalPresent: 120, // Replace with actual data
                              totalAbsent: 15, // Replace with actual data
                              totalClasses: 135, // Replace with actual data
                              monthlyData: [
                                MonthlyAttendance(
                                  month: 'January',
                                  present: 25,
                                  absent: 2,
                                ),
                                MonthlyAttendance(
                                  month: 'February',
                                  present: 22,
                                  absent: 3,
                                ),
                                // Add more months
                              ],
                              subjects:
                                  subjects
                                      .map(
                                        (s) => SubjectAttendance(
                                          name: s['name'],
                                          percentage: s['percentage'],
                                          present:
                                              20, // Replace with actual data
                                          absent: 5, // Replace with actual data
                                          totalClasses:
                                              25, // Replace with actual data
                                          recentAbsences: [
                                            DateTime(2023, 5, 10),
                                            DateTime(2023, 5, 3),
                                          ], // Replace with actual data
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                    ),
                  );
                },
                child: const Text(
                  'View All Records',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> subject) {
    final color = _getSubjectColor(subject['name']);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          // Show subject details
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(subject['icon'], color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject['name'],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AttendanceProgressBar(percentage: subject['percentage']),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${subject['percentage']}%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSubjectColor(String subjectName) {
    final colors = {
      'Mathematics': AppColors.secondary,
      'Physics': AppColors.accentBlue,
      'Chemistry': AppColors.accentPink,
      'English': AppColors.primary,
      'Computer Science': AppColors.accentAmber,
    };
    return colors[subjectName] ?? AppColors.primaryDark;
  }

  int _calculateOverallAttendance() {
    if (subjects.isEmpty) return 0;
    final total = subjects
        .map((s) => s['percentage'] as int)
        .reduce((a, b) => a + b);
    return (total / subjects.length).round();
  }
}
