import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/onboarding_flow/onboarding_flow.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/marketplace_dashboard/marketplace_dashboard.dart';
import '../presentation/product_search/product_search.dart';
import '../presentation/user_profile/user_profile.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingFlow());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const MarketplaceDashboard());
      case '/search':
        return MaterialPageRoute(builder: (_) => const ProductSearch());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const UserProfile());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
