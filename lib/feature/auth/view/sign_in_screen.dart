import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/routes/app_routes.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/core/utils/custom_snackbar.dart';
import 'package:ai_voting_app/feature/auth/cubit/auth_cubit.dart';
import 'package:ai_voting_app/feature/auth/widget/custom_elv_button.dart';
import 'package:ai_voting_app/feature/auth/widget/text_button.dart';
import 'package:flutter/material.dart';

import 'package:ai_voting_app/core/widgets/custom_input_feild.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _onSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            _isLoading = true;
          });
        }
        if (state is AuthError) {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(context, state.message, SnackBarType.error);
        }
        if (state is AuthSignedUp) {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(
            context,
            'Welcome back, ${state.user!.appMetadata['name']}!',
            SnackBarType.success,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.main,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),

                  _logoAndTitle(context),

                  const SizedBox(height: 32),

                  Text(
                    'Welcome Back!',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue voting',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurface.withAlpha(120),
                    ),
                  ),

                  const SizedBox(height: 48),

                  _dataForm(context),

                  const SizedBox(height: 32),

                  _signUpRow(context),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _logoAndTitle(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.colorScheme.primary,
                context.colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary.withAlpha(60),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.how_to_vote_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ],
    );
  }

  Container _dataForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _emailFeild(),

            const SizedBox(height: 20),

            _password(context),

            const SizedBox(height: 12),

            _forgotPass(context),

            const SizedBox(height: 24),
            CustomButton(
              text: "Sign In",
              isLoading: _isLoading,
              onPressed: _onSignIn,
            ),
          ],
        ),
      ),
    );
  }

  Align _forgotPass(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Forgot Password?",
          style: context.textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  CustomInputFeild _password(BuildContext context) {
    return CustomInputFeild(
      controller: _passwordController,
      hintText: "Enter your password",
      prefixIcon: Icons.lock_outline,
      obscureText: _obscurePassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your password";
        }

        return null;
      },
    );
  }

  CustomInputFeild _emailFeild() {
    return CustomInputFeild(
      controller: _emailController,
      hintText: "Enter your email",
      prefixIcon: Icons.email_outlined,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your email";
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return "Enter a valid email address";
        }
        return null;
      },
    );
  }

  Row _signUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface.withAlpha(120),
          ),
        ),
        CustomTextButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.signUp,
            (_) => false,
          ),
          text: 'Sign Up',
        ),
      ],
    );
  }
}
