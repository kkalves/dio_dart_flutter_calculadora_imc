// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IMCModelAdapter extends TypeAdapter<IMCModel> {
  @override
  final int typeId = 0;

  @override
  IMCModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IMCModel()
      ..id = fields[0] as String?
      ..weight = fields[1] as double?
      ..height = fields[2] as double?
      ..imcClassification = fields[3] as IMCClassification?;
  }

  @override
  void write(BinaryWriter writer, IMCModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.imcClassification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IMCModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
