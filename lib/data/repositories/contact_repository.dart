import 'package:contacts_flutter/data/models/contact_model.dart';
import 'package:hive/hive.dart';

abstract class ContactRepository {
  Future<List<ContactModel>> getAllContacts();
  Future<void> saveContact(ContactModel contact);
  Future<void> updateContact(ContactModel contact);
  Future<void> deleteContact(String id);
}

class HiveContactRepository implements ContactRepository {
  @override
  Future<void> deleteContact(String id) {
    // TODO: implement deleteContact
    throw UnimplementedError();
  }

  @override
  Future<List<ContactModel>> getAllContacts() async {
    final box = await Hive.openBox<ContactModel>('contacts');
    final contacts = box.values.toList();
    await box.close(); // Optional: Close the box explicitly
    return contacts;
  }




  @override
  Future<void> saveContact(ContactModel contact) {
    // TODO: implement saveContact
    throw UnimplementedError();
  }

  @override
  Future<void> updateContact(ContactModel contact) {
    // TODO: implement updateContact
    throw UnimplementedError();
  }
}
