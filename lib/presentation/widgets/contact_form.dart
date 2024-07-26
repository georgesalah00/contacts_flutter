import 'package:flutter/material.dart';
import '../../data/models/contact.dart';

class ContactForm extends StatefulWidget {
  final Contact? contact;
  final Function(Contact) onSave;

  const ContactForm({
    super.key,
    this.contact,
    required this.onSave,
  });

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phone;
  late String _gender;
  late int _age;
  String? _city;
  late String? _group;

  @override
  void initState() {
    super.initState();

    if (widget.contact != null) {
      _name = widget.contact!.name;
      _phone = widget.contact!.phone;
      _gender = widget.contact!.gender.name;
      _age = widget.contact!.age;
      _city = widget.contact!.city;
      _group = widget.contact!.group;
    } else {
      _name = '';
      _phone = '';
      _gender = 'male';
      _age = 0;
      _city = null;
      _group = '';
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final contact = Contact(
        name: _name,
        phone: _phone,
        gender: Gender.values.firstWhere((g) => g.name == _gender),
        age: _age,
        city: _city,
        group: _group,
      );
      widget.onSave(contact);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Male'),
                    value: 'male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Female'),
                    value: 'female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _age != 0 ? _age.toString() : '',
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _city,
                decoration: InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                onSaved: (value) {
                  _city = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _group,
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                onSaved: (value) {
                  _group = value;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green.shade400),
                  onPressed: _saveForm,
                  child: Text(widget.contact == null
                      ? 'Add Contact'
                      : 'Update Contact'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
