import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

enum Gender { male, female }

class Contact {
  late final String id;
  String name;
  String phone;
  String? group;
  Gender gender;
  int age;

  String? city;
  Contact({
    required this.name,
    required this.phone,
    this.group,
    required this.gender,
    required this.age,
    this.city,
  }) {
    id = const Uuid().v4();
  }

  static List<Contact> generateFakeContacts(int count) {
    final faker = Faker();
    final List<Contact> contacts = [];

    for (int i = 0; i < count; i++) {
      final gender =
          faker.randomGenerator.boolean() ? Gender.male : Gender.female;
      final contact = Contact(
        name: faker.person.name(),
        phone: faker.phoneNumber.us(),
        gender: gender,
        age: faker.randomGenerator.integer(100, min: 0),
        city: faker.address.city(),
        group: faker.company.name(),
      );
      contacts.add(contact);
    }

    return contacts;
  }
}
