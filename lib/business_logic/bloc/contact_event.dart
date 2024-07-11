part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {
  const ContactEvent();
}

class LoadContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final ContactModel contact;

  const AddContact(this.contact);
}

class UpdateContact extends ContactEvent {
  final ContactModel contact;

  const UpdateContact(this.contact);
}

class DeleteContact extends ContactEvent {
  final String id;

  const DeleteContact(this.id);
}
