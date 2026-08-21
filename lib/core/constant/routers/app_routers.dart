import 'package:go_router/go_router.dart';
import 'package:pet_care/features/authentication/presentation/login_screen.dart';
import 'package:pet_care/features/profile_screen/profile_page.dart';

final String profile = '/profile';
final String login = '/login';
final String upgradeToPremium = '/upgrade-to-premium';

final appRouter = GoRouter(
  initialLocation: login,
  routes: [
    GoRoute(path: login, builder: (context, state) => const LoginScreen()),
    GoRoute(path:profile,builder: (context, state)=> const ProfilePage())
    ],
);
