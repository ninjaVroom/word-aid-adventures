// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayedModelAdapter extends TypeAdapter<PlayedModel> {
  @override
  final int typeId = 3;

  @override
  PlayedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayedModel(
      user: fields[0] as UserModel?,
      level: fields[1] as LevelModel?,
      numPlayed: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayedModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.numPlayed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
