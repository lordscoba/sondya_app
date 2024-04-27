// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishListTypeAdapter extends TypeAdapter<WishListType> {
  @override
  final int typeId = 3;

  @override
  WishListType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishListType(
      id: fields[0] as String,
      category: fields[1] as String,
      name: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WishListType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishListTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
