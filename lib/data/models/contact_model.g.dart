// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactModelAdapter extends TypeAdapter<ContactModel> {
  @override
  final int typeId = 0;

  @override
  ContactModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactModel(
      name: fields[0] as String,
      phoneNumber: fields[1] as String,
      email: fields[2] as String?,
      website: fields[3] as String?,
      address: fields[4] as String?,
      note: fields[5] as String?,
      groups: (fields[6] as List).cast<String>(),
      avatarPath: fields[7] as String?,
      birthday: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ContactModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.website)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.note)
      ..writeByte(6)
      ..write(obj.groups)
      ..writeByte(7)
      ..write(obj.avatarPath)
      ..writeByte(8)
      ..write(obj.birthday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
