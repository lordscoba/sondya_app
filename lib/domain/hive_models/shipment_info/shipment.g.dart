// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShippingDestinationTypeAdapter
    extends TypeAdapter<ShippingDestinationType> {
  @override
  final int typeId = 4;

  @override
  ShippingDestinationType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShippingDestinationType(
      id: fields[0] as String,
      country: fields[1] as String,
      state: fields[2] as String,
      city: fields[3] as String,
      address: fields[4] as String,
      zipcode: fields[5] as String,
      phoneNumber: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShippingDestinationType obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.state)
      ..writeByte(3)
      ..write(obj.city)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.zipcode)
      ..writeByte(6)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShippingDestinationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
