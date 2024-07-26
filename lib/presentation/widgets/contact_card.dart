import '../../blocs/contact/contact_bloc.dart';
import '../../data/models/contact.dart';
import 'contact_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  const ContactCard({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(contact.name[0].toUpperCase()),
        ),
        title: Text(contact.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                context.read<ContactBloc>().add(ShowContactInfo(contact.id));
                Alert(
                  context: context,
                  content: BlocProvider.value(
                    value: BlocProvider.of<ContactBloc>(context),
                    child: ContactDetailsWidget(
                      contact: contact,
                    ),
                  ),
                ).show();
              },
              icon: const Icon(Icons.info),
            ),
            IconButton(
              onPressed: () {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Delete Confirmation",
                  desc: "Are you sure you want to delete this contact?",
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        context
                            .read<ContactBloc>()
                            .add(RemoveContact(contact.id));
                        Navigator.pop(context);
                      },
                      color: const Color.fromRGBO(0, 179, 134, 1.0),
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      color: const Color.fromRGBO(244, 67, 54, 1.0),
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ).show();
              },
              icon: const Icon(Icons.delete),
              style: IconButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
