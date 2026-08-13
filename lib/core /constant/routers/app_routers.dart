import 'package:go_router/go_router.dart';
import 'package:pet_care/features/home_screen/home_page.dart';


 final String home ='/home';
 final String login='/login';

final appRouter = GoRouter(
  initialLocation: home,
  routes: [
   GoRoute(path:home ,builder: (context, state) =>  const HomePage())
  ],
);
