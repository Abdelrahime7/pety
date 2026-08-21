import 'package:go_router/go_router.dart';
import 'package:pet_care/features/authentication/presentation/login_screen.dart';
import 'package:pet_care/features/home_screen/home_page.dart';

final String profile = '/profile';
final String login = '/login';
final String upgradeToPremium = '/upgrade-to-premium';

final appRouter = GoRouter(
  initialLocation: login,
  routes: [
    GoRoute(path: login, builder: (context, state) => const LoginScreen()),
    GoRoute(path:home,builder: (context, state)=> const HomePage())
    ],
);
