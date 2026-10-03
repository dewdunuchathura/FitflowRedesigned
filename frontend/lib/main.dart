import 'package:flutter/material.dart';
import 'package:fitflow/features/auth/login_screen.dart';
import 'package:fitflow/shared/theme/app_theme.dart';

void main() {
  runApp(const FitFlowApp());
}

class FitFlowApp extends StatelessWidget {
  const FitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginScreen(),
    );
  }
}
