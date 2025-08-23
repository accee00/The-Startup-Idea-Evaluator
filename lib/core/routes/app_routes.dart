import 'package:ai_voting_app/feature/auth/view/sign_in_screen.dart';
import 'package:ai_voting_app/feature/auth/view/sign_up_screen.dart';
import 'package:ai_voting_app/feature/idea/view/add_idea.dart';
import 'package:ai_voting_app/feature/idea/view/idea_screen.dart';
import 'package:ai_voting_app/feature/idea/view/main_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String main = '/main';
  static const String idea = '/idea';
  static const String addIdea = '/add-idea';
  static const String profile = '/profile';
  static const String topIdeads = '/top-ideas';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case idea:
        return MaterialPageRoute(builder: (_) => const IdeaScreen());
      case addIdea:
        return MaterialPageRoute(builder: (_) => const AddIdeaScreen());
      case profile:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Profile Screen'))),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
