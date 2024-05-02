// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthInfoAdapter extends TypeAdapter<AuthInfo> {
  @override
  final int typeId = 1;

  @override
  AuthInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthInfo(
      type: fields[0] as String,
      token: fields[1] as String,
      emailVerified: fields[2] as String,
      kycCompleted: fields[3] as String,
      id: fields[4] as String,
      email: fields[5] as String,
      username: fields[6] as String,
      phoneNumber: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthInfo obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.emailVerified)
      ..writeByte(3)
      ..write(obj.kycCompleted)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.username)
      ..writeByte(7)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
