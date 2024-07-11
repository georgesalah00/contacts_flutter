import 'package:bloc/bloc.dart';
import 'package:contacts_flutter/data/models/contact_model.dart';
import 'package:contacts_flutter/data/repositories/contact_repository.dart';
import 'package:meta/meta.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
final ContactRepository repository;

  ContactBloc(this.repository) : super(ContactInitial());

  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is LoadContacts) {
      yield ContactLoading();
      try {
        final contacts = await repository.getAllContacts();
        yield ContactsLoaded(contacts);
      } catch (e) {
        yield ContactError(e.toString());
      }
    }
    // ... similar logic for other events
  }
}
