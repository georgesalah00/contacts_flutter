import '../../blocs/contact/contact_bloc.dart';
import '../../data/models/contact.dart';
import 'chart_screen.dart';
import '../widgets/contact_card.dart';
import '../widgets/contact_form.dart';
import '../widgets/group_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ContactsPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts '),
      ),
      drawer: Drawer(
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            String? activeGroup;
            if (state is GroupSelected) {
              activeGroup = state.group;
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        final TextEditingController _groupController =
                            TextEditingController();
                        Alert(
                          context: context,
                          title: "Add New Group",
                          content: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _groupController,
                                  decoration: const InputDecoration(
                                    labelText: 'Group Name',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a group name';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          buttons: [
                            DialogButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final newGroupName = _groupController.text;
                                  context
                                      .read<ContactBloc>()
                                      .add(AddGroup(newGroupName));
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ).show();
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green),
                      child: const Text('Add Group'),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          title: const Text('All'),
                          onTap: () {
                            context.read<ContactBloc>().add(ShowAllContacts());
                            Navigator.of(context).pop();
                          },
                        ),
                        const Divider(),
                        ...state.groups!.map(
                          (group) => GroupTile(
                            isActive: group == activeGroup,
                            groupName: group!,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              Alert(
                title: 'Add Contact',
                desc:
                    'Please write the information of the contact in this form',
                context: context,
                content: ContactForm(onSave: (Contact newContact) {
                  context.read<ContactBloc>().add(AddContact(newContact));
                }),
              ).show();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 8.0,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<ContactBloc>().add(ShowCharts());
              Navigator.of(context).pushNamed(ChartScreen.id);
            },
            child: const Icon(Icons.pie_chart_sharp),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (name) {
                      context
                          .read<ContactBloc>()
                          .add(SearchContactByName(name));
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(),
                      ),
                      hintText: 'Search',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            context.read<ContactBloc>().add(SortByName());
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue),
                          child: const Text('Sort by Name'),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            context.read<ContactBloc>().add(SortByAge());
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue),
                          child: const Text('Sort by Age'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.contacts!.length,
                      itemBuilder: (context, index) => ContactCard(
                        contact: state.contacts![index],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
