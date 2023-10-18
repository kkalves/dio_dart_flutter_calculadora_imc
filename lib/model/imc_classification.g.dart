// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_classification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IMCClassificationAdapter extends TypeAdapter<IMCClassification> {
  @override
  final int typeId = 1;

  @override
  IMCClassification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IMCClassification()
      .._value = fields[0] as double
      .._description = fields[1] as String
      .._color = fields[2] as int
      .._icon = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, IMCClassification obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._value)
      ..writeByte(1)
      ..write(obj._description)
      ..writeByte(2)
      ..write(obj._color)
      ..writeByte(3)
      ..write(obj._icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IMCClassificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
