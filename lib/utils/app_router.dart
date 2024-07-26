import '../presentation/screens/chart_screen.dart';
import '../presentation/screens/contacts_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => ContactsPage(),
        );
      case ChartScreen.id:
        return MaterialPageRoute(
          builder: (context) => const ChartScreen(),
        );
    }
    return null;
  }
}
