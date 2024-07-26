import '../../blocs/contact/contact_bloc.dart';
import '../../data/models/contact.dart';
import 'contact_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactDetailsWidget extends StatelessWidget {
  final Contact contact;
  const ContactDetailsWidget({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactInfo) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._buildSingleInfo('Name', contact.name),
                  ..._buildSingleInfo('Phone', contact.phone),
                  ..._buildSingleInfo('Gender', contact.gender.name),
                  ..._buildSingleInfo('Age', contact.age.toString()),
                  ..._buildSingleInfo(
                      'city', contact.city ?? 'No City Available'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<ContactBloc>()
                              .add(UpdateContact(state.contact.id));
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green.shade400),
                        child: const Text('Edit Contact'),
                      ),
                      TextButton(
                          onPressed: () {
                            context.read<ContactBloc>().add(ShowAllContacts());
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'))
                    ],
                  )
                ]);
          } else if (state is ContactUpdating) {
            return ContactForm(
              contact: state.contact,
              onSave: (Contact newContact) {
                context.read<ContactBloc>().add(
                    UpdateContactIsSubmitted(state.contact.id, newContact));
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  List<Widget> _buildSingleInfo(String title, String data) {
    return [
      Text('$title: $data'),
      const Divider(),
      const SizedBox(
        height: 10,
      )
    ];
  }
}
