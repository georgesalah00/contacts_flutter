part of 'contact_bloc.dart';

@immutable
sealed class ContactEvent {}

class ShowAllContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final Contact contact;
  AddContact(this.contact);
}

class RemoveContact extends ContactEvent {
  final String id;
  RemoveContact(this.id);
}

class UpdateContact extends ContactEvent {
  final String oldId;
  UpdateContact(this.oldId);
}

class UpdateContactIsSubmitted extends ContactEvent {
  final String oldId;
  final Contact contact;
  UpdateContactIsSubmitted(this.oldId, this.contact);
}

class SortByName extends ContactEvent {}

class SortByAge extends ContactEvent {}

class UpdateGroup extends ContactEvent {
  final String oldGroup;
  final String newGroup;

  UpdateGroup({required this.oldGroup, required this.newGroup});
}

class FilterByGroup extends ContactEvent {
  final String group;
  FilterByGroup(this.group);
}

class RemoveGroupOnly extends ContactEvent {
  final String group;
  RemoveGroupOnly(this.group);
}

class RemoveGroupAndItsContent extends ContactEvent {
  final String group;
  RemoveGroupAndItsContent(this.group);
}

class ShowContactInfo extends ContactEvent {
  final String id;
  ShowContactInfo(this.id);
}

class SearchContactByName extends ContactEvent {
  final String name;
  SearchContactByName(this.name);
}

class ShowCharts extends ContactEvent {
}

class AddGroup extends ContactEvent{
  final String group;
  AddGroup(this.group);
}
