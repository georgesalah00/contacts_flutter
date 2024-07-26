import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:contacts_flutter/blocs/contact/contact_bloc.dart';

class GroupTile extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _groupController;
  final String? groupName;
  final bool isActive;
  GroupTile({
    super.key,
    this.groupName,
    required this.isActive,
  }) {
    _groupController = TextEditingController();
  }

  void _showEditGroupDialog(BuildContext context) {
    _groupController.text = groupName!;

    Alert(
      context: context,
      title: "Edit Group",
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
              context.read<ContactBloc>().add(
                  UpdateGroup(oldGroup: groupName!, newGroup: newGroupName));
              Navigator.pop(context);
            }
          },
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return groupName != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  context.read<ContactBloc>().add(FilterByGroup(groupName!));
                  Navigator.of(context).pop();
                },
                leading: Icon(
                  Icons.group,
                  color: isActive ? Colors.red : Colors.black,
                ),
                title: Text(
                  groupName!,
                  style: TextStyle(
                    color: isActive ? Colors.red : Colors.black,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          _showEditGroupDialog(context);
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                      onPressed: () {
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "Delete Confirmation",
                          desc: "Are you sure you want to delete this group?",
                          buttons: [
                            DialogButton(
                              onPressed: () {
                                context
                                    .read<ContactBloc>()
                                    .add(RemoveGroupOnly(groupName!));
                                Navigator.of(context).pop();
                              },
                              color: const Color.fromRGBO(0, 179, 134, 1.0),
                              child: const Text(
                                "Delete group only",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                            DialogButton(
                              onPressed: () {
                                context
                                    .read<ContactBloc>()
                                    .add(RemoveGroupAndItsContent(groupName!));
                                Navigator.of(context).pop();
                              },
                              color: const Color.fromRGBO(244, 67, 54, 1.0),
                              child: const Text(
                                "Delete Group and its Content",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ],
                        ).show();
                      },
                      icon: const Icon(Icons.delete),
                      style: IconButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ),
              const Divider()
            ],
          )
        : Container();
  }
}
