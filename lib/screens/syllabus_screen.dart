// lib/screens/syllabus_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../utils/app_design_system.dart';
import '../utils/theme.dart';

class SyllabusScreen extends StatelessWidget {
  final List<Subject> subjects = [
    Subject(
      name: 'Mathematics',
      code: 'MATH101',
      icon: Icons.calculate,
      color: AppColors.accentBlue,
      pdfPath: 'assets/pdfs/math_syllabus.pdf',
    ),
    Subject(
      name: 'Physics',
      code: 'PHYS101',
      icon: Icons.science,
      color: AppColors.accentPink,
      pdfPath: 'assets/pdfs/physics_syllabus.pdf',
    ),
    Subject(
      name: 'Chemistry',
      code: 'CHEM101',
      icon: Icons.science_outlined,
      color: AppColors.secondary,
      pdfPath: 'assets/pdfs/chemistry_syllabus.pdf',
    ),
    Subject(
      name: 'Biology',
      code: 'BIO101',
      icon: Icons.eco,
      color: AppColors.success,
      pdfPath: 'assets/pdfs/biology_syllabus.pdf',
    ),
    Subject(
      name: 'Computer Science',
      code: 'CS101',
      icon: Icons.computer,
      color: AppColors.primary,
      pdfPath: 'assets/pdfs/cs_syllabus.pdf',
    ),
    Subject(
      name: 'English',
      code: 'ENG101',
      icon: Icons.menu_book,
      color: AppColors.accentAmber,
      pdfPath: 'assets/pdfs/english_syllabus.pdf',
    ),
  ];

  SyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDesignSystem.appBar(context, 'Syllabus & Schedule'),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppDesignSystem.defaultPadding,
          child: Column(
            children: [
              AppDesignSystem.sectionHeader(
                context,
                'Available Subjects',
                actionText: 'Download All',
                onAction: () => _downloadAllPdfs(context),
              ),
              _buildSubjectGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return _buildSubjectCard(context, subjects[index]);
      },
    );
  }

  Widget _buildSubjectCard(BuildContext context, Subject subject) {
    return AppDesignSystem.card(
      context: context,
      onTap: () => _openPdfViewer(context, subject),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: subject.color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(subject.icon, size: 28, color: subject.color),
          ),
          const SizedBox(height: 12),
          Text(
            subject.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subject.code,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Future<void> _openPdfViewer(BuildContext context, Subject subject) async {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('${subject.name} Syllabus'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Would you like to view or download the syllabus?'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PdfViewerScreen(
                                  pdfPath: subject.pdfPath,
                                  subjectName: subject.name,
                                ),
                          ),
                        );
                      },
                      child: const Text('View'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _downloadPdf(context, subject);
                      },
                      child: const Text('Download'),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _downloadPdf(BuildContext context, Subject subject) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${subject.name}_syllabus.pdf';

      final data = await rootBundle.load(subject.pdfPath);
      final bytes = data.buffer.asUint8List();
      await File(filePath).writeAsBytes(bytes);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${subject.name} syllabus downloaded successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download: ${e.toString()}'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _downloadAllPdfs(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final directory = await getApplicationDocumentsDirectory();

      for (var subject in subjects) {
        final filePath = '${directory.path}/${subject.name}_syllabus.pdf';
        final data = await rootBundle.load(subject.pdfPath);
        final bytes = data.buffer.asUint8List();
        await File(filePath).writeAsBytes(bytes);
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('All syllabi downloaded successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download all: ${e.toString()}'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;
  final String subjectName;

  const PdfViewerScreen({
    required this.pdfPath,
    required this.subjectName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subjectName Syllabus'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Implement download functionality here
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.picture_as_pdf, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              'PDF Viewer Placeholder',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              'Path: $pdfPath',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Subject {
  final String name;
  final String code;
  final IconData icon;
  final Color color;
  final String pdfPath;

  Subject({
    required this.name,
    required this.code,
    required this.icon,
    required this.color,
    required this.pdfPath,
  });
}
