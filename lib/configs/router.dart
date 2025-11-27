import 'package:dorm_of_decents/configs/routes.dart';
import 'package:dorm_of_decents/ui/pages/login_page.dart';
import 'package:dorm_of_decents/ui/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [

    // initial: Splash
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),

    // Login
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
