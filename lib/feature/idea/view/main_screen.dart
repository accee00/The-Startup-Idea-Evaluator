import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/feature/idea/view/add_idea.dart';
import 'package:ai_voting_app/feature/idea/view/idea_screen.dart';
import 'package:ai_voting_app/feature/idea/view/top_idea_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const IdeaScreen(),
    AddIdeaScreen(),
    TopIdeaScreen(),
    Text('Idea Submit'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: context.colorScheme.surfaceBright, width: 1),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.lightbulb_outline,
                activeIcon: Icons.lightbulb,
                label: 'Ideas',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.add_circle_outline,
                activeIcon: Icons.add_circle,
                label: 'Submit',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.emoji_events_outlined,
                activeIcon: Icons.emoji_events,
                label: 'Top Ideas',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
      body: _screens[_currentIndex],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 20,
              color: isSelected
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFF6B7280),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
