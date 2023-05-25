// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LevelModelAdapter extends TypeAdapter<LevelModel> {
  @override
  final int typeId = 0;

  @override
  LevelModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LevelModel.easy;
      case 1:
        return LevelModel.medium;
      case 2:
        return LevelModel.difficult;
      default:
        return LevelModel.easy;
    }
  }

  @override
  void write(BinaryWriter writer, LevelModel obj) {
    switch (obj) {
      case LevelModel.easy:
        writer.writeByte(0);
        break;
      case LevelModel.medium:
        writer.writeByte(1);
        break;
      case LevelModel.difficult:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
