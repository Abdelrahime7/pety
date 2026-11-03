import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

class MainLayout extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayout({super.key, required this.navigationShell});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  DateTime? _lastBackPress;

  static const Duration _exitConfirmationDuration = Duration(seconds: 2);

  void _onItemTapped(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void _handleBackPressed() {
    final now = DateTime.now();

    final shouldExit =
        _lastBackPress != null &&
        now.difference(_lastBackPress!) < _exitConfirmationDuration;

    if (shouldExit) {
      SystemNavigator.pop();
      return;
    }

    _lastBackPress = now;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(context.l10n.pressBackAgainToExit),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.navigationShell.currentIndex;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        _handleBackPressed();
      },
      child: Scaffold(
        backgroundColor: context.colors.surface,
        body: widget.navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: _onItemTapped,
          backgroundColor: context.colors.surfaceContainer,
          selectedItemColor: context.colors.primary,
          unselectedItemColor: context.colors.onSurfaceVariant,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            height: 1.1,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            height: 1.1,
          ),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          iconSize: 22,
          items: [
            BottomNavigationBarItem(
              icon: _navIcon('assets/icons/home.png', currentIndex == 0),
              label: context.l10n.navHome,
            ),
            BottomNavigationBarItem(
              icon: _navIcon(
                'assets/icons/pets.png',
                currentIndex == 1,
                size: 26,
              ),
              label: context.l10n.navPets,
            ),
            BottomNavigationBarItem(
              icon: _navIcon(
                'assets/icons/health.png',
                currentIndex == 2,
                size: 26,
              ),
              label: context.l10n.navHealth,
            ),
            BottomNavigationBarItem(
              icon: _navIcon('assets/icons/calendar.png', currentIndex == 3),
              label: context.l10n.navCalendar,
            ),
            BottomNavigationBarItem(
              icon: _navIcon('assets/icons/profile.png', currentIndex == 4),
              label: context.l10n.navProfile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(String path, bool isSelected, {double size = 22}) {
    return SizedBox(
      height: 26,
      child: Center(
        child: Image.asset(
          path,
          width: size,
          height: size,
          color: isSelected
              ? context.colors.primary
              : context.colors.onSurfaceVariant,
        ),
      ),
    );
  }
}