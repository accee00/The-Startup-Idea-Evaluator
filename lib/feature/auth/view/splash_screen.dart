import 'package:ai_voting_app/core/bloc/app_bloc.dart';
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
          context.read<AppBloc>().add(ToggleTheme());
          Navigator.pushReplacementNamed(context, AppRoutes.main);
        } else if (state is AuthSignedOut) {
          Navigator.pushReplacementNamed(context, AppRoutes.signIn);
        } else if (state is AuthInitial) {
          Navigator.pushReplacementNamed(context, AppRoutes.signUp);
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
