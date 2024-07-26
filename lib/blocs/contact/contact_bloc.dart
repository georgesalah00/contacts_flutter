import 'package:bloc/bloc.dart';
import '../../data/models/chart_data.dart';
import '../../data/models/contact.dart';
import '../../data/repository/contact_repository.dart';

import 'package:meta/meta.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  String? _activeGroup;
  String? get activeGroup => _activeGroup;

  ContactBloc(this.contactRepository)
      : super(ContactsLoaded(
            contacts: contactRepository.contacts,
            groups: contactRepository.groups)) {
    on<AddContact>(_handleAddContact);
    on<ShowAllContacts>(_handleShowAllContacts);
    on<RemoveContact>(_handleRemoveContact);
    on<UpdateContact>(_handleUpdateContact);
    on<FilterByGroup>(_handleFilterByGroup);
    on<RemoveGroupOnly>(_handleRemoveGroupOnly);
    on<RemoveGroupAndItsContent>(_handleRemoveGroupAndItsContent);
    on<SortByAge>(_handleSortByAge);
    on<SortByName>(_handleSortByName);
    on<UpdateGroup>(_handleUpdateGroup);
    on<ShowContactInfo>(_handleShowContactInfo);
    on<UpdateContactIsSubmitted>(_handleUpdateContactIsSubmitted);
    on<SearchContactByName>(_handleSearchContactByName);
    on<ShowCharts>(_handleShowCharts);
    on<AddGroup>(_handleAddGroup);
  }

  void _handleAddContact(AddContact event, Emitter<ContactState> emit) {
    contactRepository.addContact(event.contact);
    _emitContactsLoaded(emit);
  }

  void _handleShowAllContacts(
      ShowAllContacts event, Emitter<ContactState> emit) {
    _emitContactsLoaded(emit);
  }

  void _handleRemoveContact(RemoveContact event, Emitter<ContactState> emit) {
    contactRepository.removeContact(event.id);
    _emitContactsLoaded(emit);
  }

  void _handleUpdateContact(UpdateContact event, Emitter<ContactState> emit) {
    emit(ContactUpdating(
        contact: contactRepository.getContactById(event.oldId),
        contacts: contactRepository.contacts,
        groups: contactRepository.groups));
    emit(state);
  }

  void _handleFilterByGroup(FilterByGroup event, Emitter<ContactState> emit) {
    _activeGroup = event.group;
    emit(GroupSelected(
        group: _activeGroup!,
        contacts: contactRepository.filterByGroup(event.group),
        groups: contactRepository.groups));
  }

  void _handleRemoveGroupOnly(
      RemoveGroupOnly event, Emitter<ContactState> emit) {
    contactRepository.removeGroupOnly(event.group);
    _emitContactsLoaded(emit);
  }

  void _handleRemoveGroupAndItsContent(
      RemoveGroupAndItsContent event, Emitter<ContactState> emit) {
    contactRepository.removeGroupAndItsContent(event.group);
    _emitContactsLoaded(emit);
  }

  void _handleSortByAge(SortByAge event, Emitter<ContactState> emit) {
    contactRepository.sortByAge();
    _emitContactsLoaded(emit);
  }

  void _handleSortByName(SortByName event, Emitter<ContactState> emit) {
    contactRepository.sortByName();
    _emitContactsLoaded(emit);
  }

  void _handleUpdateGroup(UpdateGroup event, Emitter<ContactState> emit) {
    contactRepository.updateGroupInAllContacts(
        oldGroupName: event.oldGroup, newGroupName: event.newGroup);
    _emitContactsLoaded(emit);
  }

  void _handleShowContactInfo(
      ShowContactInfo event, Emitter<ContactState> emit) {
    emit(ContactInfo(
        contact: contactRepository.getContactById(event.id),
        contacts: contactRepository.contacts,
        groups: contactRepository.groups));
  }

  void _handleUpdateContactIsSubmitted(
      UpdateContactIsSubmitted event, Emitter<ContactState> emit) {
    contactRepository.updateContact(event.oldId, event.contact);
    _emitContactsLoaded(emit);
  }

  void _handleSearchContactByName(
      SearchContactByName event, Emitter<ContactState> emit) {
    final List<Contact> result = contactRepository.searchByName(event.name);
    emit(ContactsLoaded(contacts: result, groups: contactRepository.groups));
  }

  void _emitContactsLoaded(Emitter<ContactState> emit) {
    emit(ContactsLoaded(
        contacts: contactRepository.contacts,
        groups: contactRepository.groups));
  }

  void _handleShowCharts(ShowCharts event, Emitter<ContactState> emit) {
    final ageChartData = contactRepository.countAgeChartData();
    final genderChartData = contactRepository.countMales();

    emit(ChartsState(
        genderChartData: genderChartData,
        contacts: contactRepository.contacts,
        groups: contactRepository.groups,
        ageChartData: ageChartData));
  }

  void _handleAddGroup(AddGroup event, Emitter<ContactState> emit) {
    contactRepository.addGroup(event.group);
    print(contactRepository.groups);
    emit(ContactsLoaded(
        contacts: contactRepository.contacts,
        groups: contactRepository.groups));
  }
}
