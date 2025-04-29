// lib/widgets/base_screen.dart
import 'package:flutter/material.dart';
import '../utils/app_design_system.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool extendBodyBehindAppBar;
  final Widget? floatingActionButton;

  const BaseScreen({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.showBackButton = true,
    this.extendBodyBehindAppBar = false,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDesignSystem.appBar(context, title, actions: actions),
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      body: Container(
        decoration: AppDesignSystem.gradientBackground(context),
        child: SafeArea(child: body),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
