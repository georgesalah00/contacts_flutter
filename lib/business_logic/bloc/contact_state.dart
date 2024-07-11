part of 'contact_bloc.dart';

@immutable
abstract class ContactState {
  const ContactState();
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {
  final bool isLoading;

  const ContactLoading({this.isLoading = false});
}

class ContactsLoaded extends ContactState {
  final List<ContactModel> contacts;

  const ContactsLoaded(this.contacts);
}

class ContactError extends ContactState {
  final String error;

  const ContactError(this.error);
}
