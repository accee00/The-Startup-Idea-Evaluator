import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/routes/app_routes.dart';
import 'package:ai_voting_app/core/utils/custom_snackbar.dart';
import 'package:ai_voting_app/feature/auth/widget/custom_elv_button.dart';
import 'package:ai_voting_app/feature/auth/widget/text_button.dart';
import 'package:flutter/material.dart';

import 'package:ai_voting_app/core/widgets/custom_input_feild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  void _onSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreeToTerms) {
        showSnackBar(
          context,
          'Please agree to the Terms & Conditions',
          SnackBarType.info,
        );
        return;
      }

      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
        showSnackBar(
          context,
          'Account created successfully! Welcome, ${_nameController.text}.',
          SnackBarType.success,
        );
      }
    }
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),

                _logoAndTitle(context),

                const SizedBox(height: 48),

                _dataForm(context),

                const SizedBox(height: 32),

                _signInRow(context),

                const SizedBox(height: 32),
              ],
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
                color: context.colorScheme.primary.withAlpha(77),
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

        const SizedBox(height: 32),

        Text(
          'Create Account',
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join us and start making your voice heard',
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurface.withAlpha(179),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Row _signInRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface.withAlpha(179),
          ),
        ),

        CustomTextButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.signIn),
          text: 'Sign In',
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _name(),

            const SizedBox(height: 20),

            _email(),

            const SizedBox(height: 20),

            _createPass(context),

            const SizedBox(height: 20),

            _confirmPass(context),

            const SizedBox(height: 24),

            _termsAndCondition(context),

            const SizedBox(height: 32),

            CustomButton(
              text: "Sign Up",
              isLoading: _isLoading,
              onPressed: _onSignUp,
            ),
          ],
        ),
      ),
    );
  }

  CustomInputFeild _name() {
    return CustomInputFeild(
      controller: _nameController,
      hintText: "Enter your full name",
      prefixIcon: Icons.person_outline,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your full name";
        }
        if (value.trim().length < 2) {
          return "Name must be at least 2 characters";
        }
        return null;
      },
    );
  }

  CustomInputFeild _email() {
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

  CustomInputFeild _createPass(BuildContext context) {
    return CustomInputFeild(
      controller: _passwordController,
      hintText: "Create a password",
      prefixIcon: Icons.lock_outline,
      obscureText: _obscurePassword,

      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: context.colorScheme.onSurface.withAlpha(153),
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a password";
        }

        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }

  CustomInputFeild _confirmPass(BuildContext context) {
    return CustomInputFeild(
      controller: _confirmPasswordController,
      hintText: "Confirm your password",
      prefixIcon: Icons.lock_outline,
      obscureText: _obscureConfirmPassword,

      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: context.colorScheme.onSurface.withAlpha(153),
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          });
        },
      ),
      validator: _validateConfirmPassword,
    );
  }

  Row _termsAndCondition(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
          activeColor: context.colorScheme.primary,
          visualDensity: VisualDensity.compact,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _agreeToTerms = !_agreeToTerms;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: RichText(
                text: TextSpan(
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface.withAlpha(179),
                  ),
                  children: [
                    const TextSpan(text: "I agree to the "),
                    TextSpan(
                      text: "Terms & Conditions",
                      style: TextStyle(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
