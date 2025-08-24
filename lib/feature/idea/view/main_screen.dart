import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/feature/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/feature/idea/view/add_idea.dart';
import 'package:ai_voting_app/feature/idea/view/idea_screen.dart';
import 'package:ai_voting_app/feature/idea/view/top_idea_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const IdeaScreen(),
    const AddIdeaScreen(),
    const TopIdeaScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.getBackgroundColor(context),
      body: _screens[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppTheme.getCardColor(context),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withAlpha(100)
                    : Colors.black.withAlpha(40),
                blurRadius: 20,
                offset: const Offset(0, -5),
                spreadRadius: 0,
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: GNav(
                gap: 8,
                tabBorderRadius: 12,
                curve: Curves.easeInOutCubic,
                duration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                color: AppTheme.getTextSecondary(context),
                activeColor: isDark
                    ? AppTheme.primaryBlue
                    : AppTheme.primaryBlue,
                tabBackgroundColor: isDark
                    ? AppTheme.primaryBlue.withAlpha(40)
                    : AppTheme.blueLight,
                tabMargin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                iconSize: 22,
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppTheme.primaryBlue : AppTheme.primaryBlue,
                ),
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },

                tabs: [
                  _buildNavButton(
                    context: context,
                    index: 0,
                    activeIcon: Icons.lightbulb,
                    inactiveIcon: Icons.lightbulb_outline,
                    text: "Ideas",
                  ),
                  _buildNavButton(
                    context: context,
                    index: 1,
                    activeIcon: Icons.add_circle,
                    inactiveIcon: Icons.add_circle_outline,
                    text: "Submit",
                  ),
                  _buildNavButton(
                    context: context,
                    index: 2,
                    activeIcon: Icons.emoji_events,
                    inactiveIcon: Icons.emoji_events_outlined,
                    text: "Top Ideas",
                  ),
                  _buildNavButton(
                    context: context,
                    index: 3,
                    activeIcon: Icons.person,
                    inactiveIcon: Icons.person_outline,
                    text: "Profile",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GButton _buildNavButton({
    required BuildContext context,
    required int index,
    required IconData activeIcon,
    required IconData inactiveIcon,
    required String text,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isActive = _currentIndex == index;

    return GButton(
      textStyle: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: isActive
            ? (isDark ? AppTheme.primaryBlue : AppTheme.primaryBlue)
            : AppTheme.getTextSecondary(context),
      ),
      icon: isActive ? activeIcon : inactiveIcon,
      text: text,
      iconColor: isActive
          ? (isDark ? AppTheme.primaryBlue : AppTheme.primaryBlue)
          : AppTheme.getTextSecondary(context),
    );
  }
}
