import 'package:go_router/go_router.dart';
import 'package:pet_care/features/authentication/presentation/login_screen.dart';
import 'package:pet_care/features/pets/presentation/screens/add_pet_screen.dart';
import 'package:pet_care/features/profile_screen/profile_page.dart';
import 'package:pet_care/features/upgradetopremium/upgrad_to_premium_screen.dart';

final String profile = '/profile';
final String login = '/login';
final String upgradeToPremium = '/upgrade-to-premium';
final String addPet = '/add-pet';

final appRouter = GoRouter(
  initialLocation: addPet,
  routes: [
    GoRoute(path: login, builder: (context, state) => const LoginScreen()),
    GoRoute(path:profile,builder: (context, state)=> const ProfilePage()),
    GoRoute(path:upgradeToPremium,builder: (context, state)=> const UpgradeToPremiumScreen()),
    GoRoute(path:addPet,builder: (context, state)=>  AddPetScreen())


    ],
);
