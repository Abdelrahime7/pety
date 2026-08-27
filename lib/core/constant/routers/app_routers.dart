import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/features/authentication/presentation/login_screen.dart';
import 'package:pet_care/features/pets/screens/add_pet_screen.dart';
import 'package:pet_care/features/pets/screens/pets_list_screen.dart';
<<<<<<< HEAD
import 'package:pet_care/features/users/presentation/upgrad_to_premium_screen.dart';
import 'package:pet_care/features/users/presentation/profile_screen.dart';
=======
import 'package:pet_care/features/profile/profile_page.dart';
import 'package:pet_care/features/profile/profile_info_screen.dart';
import 'package:pet_care/features/upgradetopremium/upgrad_to_premium_screen.dart';
>>>>>>> main
import 'package:pet_care/core/layout/main_layout.dart';

final String profile = '/profile';
final String login = '/login';
final String upgradeToPremium = '/upgrade-to-premium';
final String petList = '/pet-list';
final String addNewPet = '/add-new-pet';
final String profileInfo = '/profile-info';

final appRouter = GoRouter(
  initialLocation:login ,
  routes: [

    /// Screens WITHOUT bottom nav
<<<<<<< HEAD
    GoRoute(path: login, builder: (_, _) => const LoginScreen()),
    GoRoute(path: addNewPet, builder: (_, _) => const AddPetScreen()),
    GoRoute(path: upgradeToPremium, builder: (_, _) => const UpgradeToPremiumScreen()),
=======
    GoRoute(path: login, builder: (_, __) => const LoginScreen()),
    GoRoute(path: addNewPet, builder: (_, __) => const AddPetScreen()),
    GoRoute(path: upgradeToPremium, builder: (_, __) => const UpgradeToPremiumScreen()),
    GoRoute(path: profileInfo, builder: (_, __) =>  ProfileInfoScreen()),
>>>>>>> main

    /// Screens WITH bottom nav
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/home', 
          builder: (_, _) => const Scaffold(body: Center(child: Text("Home coming soon..."))),
        ),
        GoRoute(path: petList, builder: (_, _) => PetsListScreen()),
        GoRoute(
          path: '/health', 
          builder: (_, _) => const Scaffold(body: Center(child: Text("Health coming soon..."))),
        ),
        GoRoute(
          path: '/calendar', 
          builder: (_, _) => const Scaffold(body: Center(child: Text("Calendar coming soon..."))),
        ),
        GoRoute(path: profile, builder: (_, _) => const ProfilePage()),
      ],
    ),
  ],
);
