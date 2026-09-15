import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/layout/main_layout.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/add_appointment_screen.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/appointments_screen.dart';
import 'package:pet_care/features/authentication/presentation/login_screen.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/screens/add_pet_screen.dart';
import 'package:pet_care/features/pets/screens/pet_details_screen.dart';
import 'package:pet_care/features/pets/screens/pet_edit_screen.dart';
import 'package:pet_care/features/pets/screens/pets_list_screen.dart';
import 'package:pet_care/features/users/presentation/personal_information.dart';
import 'package:pet_care/features/users/presentation/profile_screen.dart';
import 'package:pet_care/features/users/presentation/upgrad_to_premium_screen.dart';

const String profile = '/profile';
const String login = '/login';
const String upgradeToPremium = '/upgrade-to-premium';
const String petList = '/pet-list';
const String addNewPet = '/add-new-pet';
const String profileInfo = '/profile-info';
const String petDetails = '/pet-details';
const String petEdit = '/Pet-Edit';
const String calendar = '/calendar';
const String addNewAppointment = '/add-new-appointment';

final appRouter = GoRouter(
  initialLocation: calendar,
  routes: [
    /// Screens WITHOUT bottom nav
    GoRoute(path: login, builder: (_, __) => const LoginScreen()),
    GoRoute(path: addNewPet, builder: (_, __) => const AddPetScreen()),
    GoRoute(path: addNewAppointment, builder: (_, __) => const AddAppointmentScreen()),
    GoRoute(
      path: upgradeToPremium,
      builder: (_, __) => const UpgradeToPremiumScreen(),
    ),
    GoRoute(path: profileInfo, builder: (_, __) => ProfileInfoScreen()),

    /// Screens WITH bottom nav
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (_, _) => const Scaffold(
            body: Center(child: Text("Home coming soon...")),
          ),
        ),
        GoRoute(path: petList, builder: (_, _) => PetsListScreen()),
        GoRoute(
          path: '/health',
          builder: (_, _) => const Scaffold(
            body: Center(child: Text("Health coming soon...")),
          ),
        ),
        GoRoute(
          path: calendar,
          builder: (_, _) => const AppointmentsScreen(),
        ),
        GoRoute(path: profile, builder: (_, _) => const ProfilePage()),
        GoRoute(
          path: petDetails,
          builder: (context, state) {
            final pet = state.extra as Pet;
            return PetDetailsScreen(petId: pet.id);
          },
        ),
        GoRoute(
          path: petEdit,
          builder: (context, state) {
            final pet = state.extra as Pet;
            return PetEditScreen(pet: pet);
          },
        ),
      ],
    ),
  ],
);