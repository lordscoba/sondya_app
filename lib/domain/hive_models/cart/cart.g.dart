// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductOrderTypeAdapter extends TypeAdapter<ProductOrderType> {
  @override
  final int typeId = 2;

  @override
  ProductOrderType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductOrderType(
      id: fields[0] as String,
      selectedVariants: (fields[1] as List?)
          ?.map((dynamic e) => (e as List).cast<String>())
          .toList(),
      orderQuantity: fields[2] as int,
      trackDistanceTime: fields[3] as TrackDistanceTimeType?,
      name: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductOrderType obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.selectedVariants)
      ..writeByte(2)
      ..write(obj.orderQuantity)
      ..writeByte(3)
      ..write(obj.trackDistanceTime)
      ..writeByte(4)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductOrderTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
