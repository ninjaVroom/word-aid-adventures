// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CrosswordAnswerModelAdapter extends TypeAdapter<CrosswordAnswerModel> {
  @override
  final int typeId = 5;

  @override
  CrosswordAnswerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CrosswordAnswerModel(
      (fields[2] as Map).cast<String, dynamic>(),
      numBoxPerRow: fields[4] as int,
    )
      ..done = fields[0] as bool
      ..indexArray = fields[1] as int
      ..answerLines = (fields[3] as List).cast<int>();
  }

  @override
  void write(BinaryWriter writer, CrosswordAnswerModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.done)
      ..writeByte(1)
      ..write(obj.indexArray)
      ..writeByte(2)
      ..write(obj.wordSearchLocation)
      ..writeByte(3)
      ..write(obj.answerLines)
      ..writeByte(4)
      ..write(obj.numBoxPerRow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrosswordAnswerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
