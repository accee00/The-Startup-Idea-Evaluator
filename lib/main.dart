import 'package:ai_voting_app/core/routes/app_routes.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';

import 'package:ai_voting_app/feature/auth/view/sign_up_screen.dart';

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppRoutes.signUp,
      onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
      theme: AppTheme.darkTheme,
    );
  }
}
