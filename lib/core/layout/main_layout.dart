import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/pet-list')) return 1;
    if (location.startsWith('/health')) return 2;
    if (location.startsWith('/calendar')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 1;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0: context.go('/home'); break;
      case 1: context.go('/pet-list'); break;
      case 2: context.go('/health'); break;
      case 3: context.go('/calendar'); break;
      case 4: context.go('/profile'); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: child,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(index, context),

        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: const Color(0xFF94A3B8),

        selectedFontSize: 11,
        unselectedFontSize: 11,

        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          height: 1.1, // tighter spacing
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          height: 1.1,
        ),

        type: BottomNavigationBarType.fixed,
        elevation: 0,
        iconSize: 22, // unified icon size

        items: [
          BottomNavigationBarItem(
            icon: _navIcon('assets/icons/home.png', currentIndex == 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _navIcon('assets/icons/pets.png', currentIndex == 1,size: 26),
            label: 'Pets',
          ),
          BottomNavigationBarItem(
            icon: _navIcon('assets/icons/health.png', currentIndex == 2,size: 26),
            label: 'Health',
          ),
          BottomNavigationBarItem(
            icon: _navIcon('assets/icons/calendar.png', currentIndex == 3),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: _navIcon('assets/icons/profile.png', currentIndex == 4),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _navIcon(String path, bool isSelected,{double? size = 22}) {
    return SizedBox(
      height: 26, // forces equal vertical alignment
      child: Center(
        child: Image.asset(
          path,
          width: size,
          height: size,
          color: isSelected ? AppColors.primary : const Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
