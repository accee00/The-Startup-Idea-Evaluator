import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';

import 'package:ai_voting_app/feature/idea/widget/custom_app_bar.dart';
import 'package:ai_voting_app/core/widgets/custom_input_feild.dart';
import 'package:flutter/material.dart';

class AddIdeaScreen extends StatefulWidget {
  const AddIdeaScreen({super.key});

  @override
  State<AddIdeaScreen> createState() => _AddIdeaScreenState();
}

class _AddIdeaScreenState extends State<AddIdeaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ideaController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getBackgroundColor(context),
      appBar: const CustomAppBar(title: "Submit Your Idea", showBack: true),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _expContainer(context),
                const SizedBox(height: 20),
                Text('Idea Title', style: context.textTheme.titleMedium),
                const SizedBox(height: 8),
                CustomInputFeild(
                  controller: _ideaController,
                  hintText: 'Enter your idea here',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your idea title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text('Category', style: context.textTheme.titleMedium),
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
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: AppTheme.getCategoryColor(
                                      category,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    category,
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
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
                const SizedBox(height: 20),
                Text('Description', style: context.textTheme.titleMedium),
                const SizedBox(height: 8),
                CustomInputFeild(
                  controller: _descriptionController,
                  hintText:
                      'Describe your idea in detail.\nWhat problem does it solve? How is it innovative?',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Container(
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle submit
                      }
                    },
                    icon: const Icon(Icons.send_outlined, color: Colors.white),
                    label: Text(
                      'Submit Idea',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _expContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Our AI will analyze your idea and provide instant\nfeedback on market potential, innovation, and feasibility!',
            textAlign: TextAlign.justify,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.primary.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }
}
