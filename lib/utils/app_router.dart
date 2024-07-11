import 'package:contacts_flutter/presentation/screens/contacts_page.dart';
import 'package:flutter/material.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings options){
    switch (options.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => ContactsPage()) ;

    }
    return null;
  }
}