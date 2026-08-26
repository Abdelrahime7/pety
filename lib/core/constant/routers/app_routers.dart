import 'package:go_router/go_router.dart';
import 'package:pet_care/features/authentication/presentation/login_screen.dart';
import 'package:pet_care/features/pets/screens/add_pet_screen.dart';
import 'package:pet_care/features/pets/screens/pets_list_screen.dart';
import 'package:pet_care/features/users/presentation/upgrad_to_premium_screen.dart';
import 'package:pet_care/features/users/presentation/profile_screen.dart';

final String profile = '/profile';
final String login = '/login';
final String upgradeToPremium = '/upgrade-to-premium';
final String petList = '/pet-list';
final String addNewPet = '/add-new-pet';  //

final appRouter = GoRouter(
  initialLocation: profile,
  routes: [
    GoRoute(path: login, builder: (context, state) => const LoginScreen()),
    GoRoute(path:profile,builder: (context, state)=> const ProfilePage()),
    GoRoute(path:upgradeToPremium,builder: (context, state)=> const UpgradeToPremiumScreen()),
    GoRoute(path:petList,builder: (context,state)=>const PetsListScreen()),
    GoRoute(path:addNewPet,builder: (context, state)=> const AddPetScreen()),


    ],
);
