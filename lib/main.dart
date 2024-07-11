import 'package:contacts_flutter/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  runApp(ContactsApp(
    appRouter: AppRouter(),
  ));
}

class ContactsApp extends StatelessWidget {
  final AppRouter appRouter;
  const ContactsApp({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
