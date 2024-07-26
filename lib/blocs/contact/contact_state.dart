part of 'contact_bloc.dart';

@immutable
sealed class ContactState {
  final List<Contact>? contacts;
  final List<String?>? groups;

  const ContactState({
    this.contacts,
    this.groups,
  });
}

final class ContactsLoaded extends ContactState {
  const ContactsLoaded({required super.contacts, required super.groups});
}

final class ContactInfo extends ContactState {
  final Contact contact;

  const ContactInfo(
      {required super.contacts, required super.groups, required this.contact});
}

final class ContactUpdating extends ContactState {
  final Contact contact;

  const ContactUpdating(
      {required super.contacts, required super.groups, required this.contact});
}

final class GroupSelected extends ContactState {
  final String group;

  const GroupSelected(
      {required super.contacts, required super.groups, required this.group});
}

final class ChartsState extends ContactState {
  final List<ChartData> ageChartData;
  final List<GenderData> genderChartData;

  const ChartsState(
      {super.contacts,
      super.groups,
      required this.ageChartData,
      required this.genderChartData});
}
