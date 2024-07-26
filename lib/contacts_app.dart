import 'blocs/contact/contact_bloc.dart';
import 'data/repository/contact_repository.dart';
import 'utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsApp extends StatelessWidget {
  final AppRouter router;
  const ContactsApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(ContactRepository()),
      child: MaterialApp(
        title: 'Contacts',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
