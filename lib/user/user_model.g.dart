// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      displayName: fields[0] as String,
      email: fields[1] as String,
      emailVerified: fields[2] as bool,
      isAnonymous: fields[3] as bool,
      metadata: fields[4] as UserMetadata,
      phoneNumber: fields[5] as String,
      photoURL: fields[6] as String,
      providerData: (fields[7] as List).cast<UserInfo>(),
      refreshToken: fields[8] as String,
      tenantId: fields[9] as String,
      uid: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.emailVerified)
      ..writeByte(3)
      ..write(obj.isAnonymous)
      ..writeByte(4)
      ..write(obj.metadata)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.photoURL)
      ..writeByte(7)
      ..write(obj.providerData)
      ..writeByte(8)
      ..write(obj.refreshToken)
      ..writeByte(9)
      ..write(obj.tenantId)
      ..writeByte(10)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
