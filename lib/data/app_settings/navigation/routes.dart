import 'package:flutter/material.dart';
import '../../../ui/screens/home.dart';
import '../../../ui/screens/onboarding/ui/onboarding_screen.dart';

abstract class MainNavigationRoutes {
  static const String home = '/';
  static const String onboarding = '/onboarding';
}

final routes = {
  MainNavigationRoutes.home: (BuildContext context) => const MyHomePage(),
  MainNavigationRoutes.onboarding: (BuildContext context) =>
      const OnBoardingScreen(),
};
