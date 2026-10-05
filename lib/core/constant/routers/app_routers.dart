import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/layout/main_layout.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/screens/appointments_screen.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/screens/add_appointment_screen.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/screens/appointment_details.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/screens/edit_appointment_screen.dart';
import 'package:pet_care/features/authentication/presentation/login_screen.dart';
import 'package:pet_care/features/health/presentation/screens/health_screen.dart';
import 'package:pet_care/features/health/presentation/screens/health_records_screen.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';
import 'package:pet_care/features/health/vaccination/presentation/screens/add_vaccination.dart';
import 'package:pet_care/features/health/vaccination/presentation/screens/vaccination_details.dart';
import 'package:pet_care/features/health/vaccination/presentation/screens/vaccinations_list.dart';
import 'package:pet_care/features/notifications/presentation/screens/notification_settings_screen.dart';
import 'package:pet_care/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/screens/add_pet_screen.dart';
import 'package:pet_care/features/pets/screens/pet_details_screen.dart';
import 'package:pet_care/features/pets/screens/pet_edit_screen.dart';
import 'package:pet_care/features/pets/screens/pets_list_screen.dart';
import 'package:pet_care/features/users/domain/entity/user.dart';
import 'package:pet_care/features/users/presentation/personal_information.dart';
import 'package:pet_care/features/users/presentation/profile_screen.dart';
import 'package:pet_care/features/users/presentation/upgrad_to_premium_screen.dart';

final String profile = '/profile';
final String login = '/login';
final String upgradeToPremium = '/upgrade-to-premium';
final String petList = '/pet-list';
final String addNewPet = '/add-new-pet';
final String profileInfo = '/profile-info';
final String petDetails ='/pet-details';
final String petEdit = '/Pet-Edit';
final String addVaccination = '/Add-Vaccination';
final String vaccinationList= '/Vaccination-List';
final String vaccinationDetails='/vaccination-Details';
const String calendar = '/calendar';
const String addNewAppointment = '/add-new-appointment';
const String appointmentDetails = '/appointment-details';
const String appointmentEdit = '/appointment-edit';
const String home = '/home';
const String health = '/health';
const String healthRecords = '/health-records';
const String notifications= '/notifications';
const String notificationSettings ='/notificationSettings';

final appRouter = GoRouter(
  initialLocation: login,
  routes: [
    /// Screens WITHOUT bottom nav
    GoRoute(path: login, builder: (_, _) => const LoginScreen()),
    GoRoute(path: addNewPet, builder: (_, _) => const AddPetScreen()),
    GoRoute(
      path: addNewAppointment,
      builder: (_, _) => const AddAppointmentScreen(),
    ),
    GoRoute(
      path: appointmentDetails,
      builder: (_, state) =>
          AppointmentDetailsScreen(appointment: state.extra! as Appointment),
    ),
    GoRoute(
      path: appointmentEdit,
      builder: (_, state) =>
          EditAppointmentScreen(appointment: state.extra! as Appointment),
    ),
    GoRoute(
      path: upgradeToPremium,
      builder: (_, _) => const UpgradeToPremiumScreen(),
    ),
    GoRoute(path: profileInfo, builder: (_, _) => ProfileInfoScreen()),
    GoRoute(
      path: healthRecords,
      builder: (_, state) => HealthRecordsScreen(pet: state.extra as Pet?),
    ),

     GoRoute(path: addVaccination ,builder: (context,state ){
             final petId = state.extra as String ;
            return AddVaccinationScreen(petId: petId);
           }       
          ),
     GoRoute(path: vaccinationList , builder: ( context, state)
          {
            final petId = state.extra as String ;
            return VaccinationListScreen(petId:petId) ;
          }
          ),
    GoRoute(path: vaccinationDetails , builder: ( context, state)
          {
            final vaccination = state.extra as VaccinationSerie ;
            return VaccinationDetailsScreen(vaccination:vaccination) ;
          }
          ),    


     GoRoute(path: petDetails,builder:(context ,stat) {
           final pet = stat.extra as Pet ;
           return  PetDetailsScreen(pet:pet);
          }),

      GoRoute(path: petEdit,builder:(context ,state) {
           final pet = state.extra as Pet ;
           return  PetEditScreen(pet:pet);
          }),

          GoRoute(
  path: notifications,
  builder: (context, state) {
    return const NotificationsScreen();
  },
),
GoRoute(
  path: notificationSettings,
  builder: (context, state) {
    final user =state.extra as User;
    return  NotificationSettingsScreen(user: user,);
  },
),

    /// Screens WITH bottom nav
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (_, _) =>
              const Scaffold(body: Center(child: Text("Home coming soon..."))),
        ),
        
        GoRoute(path: petList, builder: (_, _) => PetsListScreen()),
        GoRoute(path: health, builder: (_, _) => HealthScreen()),
        GoRoute(path: calendar, builder: (_, _) => const AppointmentsScreen()),
        GoRoute(path: profile, builder: (_, _) => const ProfilePage()),

      
         
  
      ],
    ),
  ],
);
