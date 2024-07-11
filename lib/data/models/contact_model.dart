import 'package:hive/hive.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class ContactModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String phoneNumber;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? website;
  @HiveField(4)
  final String? address;
  @HiveField(5)
  final String? note;
  @HiveField(6)
  final List<String> groups;
  @HiveField(7)
  final String? avatarPath;
  @HiveField(8)
  final DateTime? birthday;

  ContactModel({
    required this.name,
    required this.phoneNumber,
    this.email,
    this.website,
    this.address,
    this.note,
    this.groups = const [],
    this.avatarPath,
    this.birthday,
  });
}