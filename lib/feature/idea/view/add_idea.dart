import 'dart:math';

import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/routes/app_routes.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/core/utils/custom_snackbar.dart';
import 'package:ai_voting_app/feature/idea/cubit/idea_cubit.dart';
import 'package:ai_voting_app/feature/idea/model/startup_idea_model.dart';

import 'package:ai_voting_app/feature/idea/widget/custom_app_bar.dart';
import 'package:ai_voting_app/core/widgets/custom_input_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddIdeaScreen extends StatefulWidget {
  const AddIdeaScreen({super.key});

  @override
  State<AddIdeaScreen> createState() => _AddIdeaScreenState();
}

class _AddIdeaScreenState extends State<AddIdeaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ideaController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagLineController = TextEditingController();
  String? _selectedCategory;
  bool isLoading = false;
  @override
  void dispose() {
    _ideaController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  void _submitIdea() {
    if (_selectedCategory == null) {
      showSnackBar(context, 'Select a category.', SnackBarType.error);
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      final random = Random();
      final aiRating = random.nextInt(11).toDouble();

      final idea = StartupIdeaModel(
        title: _ideaController.text.trim(),
        description: _descriptionController.text.trim(),
        tagline: _tagLineController.text.trim(),
        category: _selectedCategory!,
        aiRating: aiRating,
        votes: 0,
        hasVoted: false,
        createdAt: DateTime.now(),
      );
      setState(() {
        isLoading = true;
      });
      context.read<IdeaCubit>().addStartupIdea(idea);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IdeaCubit, IdeaState>(
      listener: (context, state) {
        if (state is AddStartupIdeaSuccessState) {
          setState(() {
            isLoading = false;
          });
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.main,
              (_) => false,
            );
          }
          showSnackBar(
            context,
            'Idea added successfully!',
            SnackBarType.success,
          );
        }
        if (state is AddStartupIdeaFailureState) {
          Navigator.pop(context);
          setState(() {
            isLoading = false;
          });
          showSnackBar(context, state.errorMessage, SnackBarType.success);
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.getBackgroundColor(context),
        appBar: const CustomAppBar(title: "Submit Your Idea", showBack: true),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                minimum: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _expContainer(context),
                        _buildTextFeild(
                          context,
                          controller: _ideaController,
                          heading: 'Idea Title',
                          hintText: 'Enter your idea here',
                          validatorText: 'Please enter your idea title',
                        ),
                        _buildTextFeild(
                          context,
                          controller: _tagLineController,
                          heading: 'Tag Line',
                          hintText: 'Enter your tag line',
                        ),
                        const SizedBox(height: 20),

                        _categorySelector(context),
                        _buildTextFeild(
                          controller: _descriptionController,
                          context,
                          heading: 'Description',
                          maxLine: 4,
                          hintText:
                              'Describe your idea in detail.\nWhat problem does it solve? How is it innovative?',
                          validatorText: 'Please enter a description',
                        ),
                        const SizedBox(height: 30),
                        _submitButton(context),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Column _categorySelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category', style: context.textTheme.titleLarge),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          items:
              [
                    'AI/ML',
                    'Tech',
                    'Health & Wellness',
                    'Sustainability',
                    'Blockchain',
                    'Education',
                    'Finance',
                    'Social',
                  ]
                  .map(
                    (category) => DropdownMenuItem<String>(
                      value: category,
                      child: Text(category, style: context.textTheme.bodyLarge),
                    ),
                  )
                  .toList(),

          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
          hint: Text(
            'Select Category',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withAlpha(150),
            ),
          ),
        ),
      ],
    );
  }

  Container _submitButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: AppTheme.greenBlueLinearGradient,
        boxShadow: AppTheme.elevatedShadow,
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _submitIdea,
        icon: const Icon(Icons.send_outlined, color: Colors.white),
        label: Text(
          'Submit Idea',
          style: context.textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Column _buildTextFeild(
    BuildContext context, {
    required String heading,
    required String hintText,
    required TextEditingController controller,
    String? validatorText,
    int? maxLine,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(heading, style: context.textTheme.titleLarge),
        const SizedBox(height: 8),
        CustomInputFeild(
          controller: controller,
          hintText: hintText,
          maxLines: maxLine,
          validator: validatorText != null && validatorText.isNotEmpty
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return validatorText;
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Container _expContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.getBorderColor(context)),
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.getAccentColor(context, 'blue'),
        boxShadow: AppTheme.cardShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI-Powered Feedback',
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Our AI will analyze your idea and provide instant feedback on market potential, innovation, and feasibility!',

            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.primary.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }
}
