import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../widgets/attendance_progress_bar.dart';
import '../models/attendance_model.dart';
import 'package:intl/intl.dart';

class AttendanceRecordsScreen extends StatefulWidget {
  final AttendanceSummary summary;

  const AttendanceRecordsScreen({super.key, required this.summary});

  @override
  State<AttendanceRecordsScreen> createState() =>
      _AttendanceRecordsScreenState();
}

class _AttendanceRecordsScreenState extends State<AttendanceRecordsScreen> {
  int _selectedTab = 0; // 0 for general, 1 for subject-wise

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Records'),
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
        child: Column(
          children: [
            // Tab selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTabButton(
                      context,
                      label: 'General',
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTabButton(
                      context,
                      label: 'Subject-wise',
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                ],
              ),
            ),

            // Content based on selected tab
            Expanded(
              child:
                  _selectedTab == 0
                      ? _buildGeneralAttendanceView(context)
                      : _buildSubjectWiseView(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: isSelected ? AppColors.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.transparent : AppColors.primary,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGeneralAttendanceView(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Overall summary card
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
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
                        '${widget.summary.overallPercentage}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AttendanceProgressBar(
                    percentage: widget.summary.overallPercentage,
                  ),
                  const SizedBox(height: 16),
                  _buildStatRow(
                    present: widget.summary.totalPresent,
                    absent: widget.summary.totalAbsent,
                    total: widget.summary.totalClasses,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Monthly breakdown
          Text(
            'Monthly Breakdown',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...widget.summary.monthlyData.map(
            (monthData) => _buildMonthCard(
              context,
              month: monthData.month,
              present: monthData.present,
              absent: monthData.absent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectWiseView(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.summary.subjects.length,
      itemBuilder: (context, index) {
        final subject = widget.summary.subjects[index];
        return _buildSubjectCard(context, subject);
      },
    );
  }

  Widget _buildStatRow({
    required int present,
    required int absent,
    required int total,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(
          value: present,
          label: 'Present',
          color: AppColors.success,
        ),
        _buildStatItem(value: absent, label: 'Absent', color: AppColors.error),
        _buildStatItem(value: total, label: 'Total', color: AppColors.primary),
      ],
    );
  }

  Widget _buildStatItem({
    required int value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildMonthCard(
    BuildContext context, {
    required String month,
    required int present,
    required int absent,
  }) {
    final total = present + absent;
    final percentage = total == 0 ? 0 : (present / total * 100).round();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  month,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _getPercentageColor(percentage),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AttendanceProgressBar(percentage: percentage),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Present: $present',
                  style: TextStyle(color: AppColors.success),
                ),
                Text(
                  'Absent: $absent',
                  style: TextStyle(color: AppColors.error),
                ),
                Text(
                  'Total: $total',
                  style: TextStyle(color: AppColors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, SubjectAttendance subject) {
    final color = _getSubjectColor(subject.name);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(_getSubjectIcon(subject.name), color: color, size: 24),
        ),
        title: Text(
          subject.name,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          '${subject.percentage}%',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        children: [
          // Attendance progress bar
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: AttendanceProgressBar(percentage: subject.percentage),
          ),

          // Stats row
          _buildStatRow(
            present: subject.present,
            absent: subject.absent,
            total: subject.totalClasses,
          ),

          const SizedBox(height: 24),

          // Recent absences section
          if (subject.recentAbsences.isNotEmpty) ...[
            Divider(color: Colors.grey[300], height: 1),
            const SizedBox(height: 16),

            // Section header
            Row(
              children: [
                Icon(Icons.calendar_month, color: AppColors.error, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Recent Absences',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Absences list
            Column(
              children:
                  subject.recentAbsences
                      .map(
                        (date) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildAbsenceItem(date, color),
                        ),
                      )
                      .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAbsenceItem(DateTime date, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              date.day.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getDayName(date),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${_getMonthName(date)} ${date.year}',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  String _getDayName(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  Color _getPercentageColor(int percentage) {
    if (percentage >= 85) return Colors.green;
    if (percentage >= 70) return Colors.orange;
    return Colors.red;
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

  IconData _getSubjectIcon(String subjectName) {
    final icons = {
      'Mathematics': Icons.calculate,
      'Physics': Icons.science,
      'Chemistry': Icons.emoji_objects,
      'English': Icons.menu_book,
      'Computer Science': Icons.computer,
    };
    return icons[subjectName] ?? Icons.subject;
  }
}
