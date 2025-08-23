import 'package:ai_voting_app/core/routes/app_routes.dart';
import 'package:ai_voting_app/feature/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        print(state.runtimeType);
        if (state is AuthUserState) {
          Navigator.pushReplacementNamed(context, AppRoutes.main);
        } else if (state is AuthSignedOut) {
          Navigator.pushReplacementNamed(context, '/sign-in');
        } else if (state is AuthError) {}
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
