import 'package:flutter/material.dart';
import '../../../ui/screens/home.dart';

abstract class MainNavigationRoutes {
  static const String home = '/';
}

final routes = {
  MainNavigationRoutes.home: (BuildContext context) => const MyHomePage(),
};
