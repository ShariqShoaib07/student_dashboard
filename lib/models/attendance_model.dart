class AttendanceSummary {
  final int overallPercentage;
  final int totalPresent;
  final int totalAbsent;
  final int totalClasses;
  final List<MonthlyAttendance> monthlyData;
  final List<SubjectAttendance> subjects;

  AttendanceSummary({
    required this.overallPercentage,
    required this.totalPresent,
    required this.totalAbsent,
    required this.totalClasses,
    required this.monthlyData,
    required this.subjects,
  });
}

class MonthlyAttendance {
  final String month;
  final int present;
  final int absent;

  MonthlyAttendance({
    required this.month,
    required this.present,
    required this.absent,
  });
}

class SubjectAttendance {
  final String name;
  final int percentage;
  final int present;
  final int absent;
  final int totalClasses;
  final List<DateTime> recentAbsences;

  SubjectAttendance({
    required this.name,
    required this.percentage,
    required this.present,
    required this.absent,
    required this.totalClasses,
    required this.recentAbsences,
  });
}
