// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReadHistoryAdapter extends TypeAdapter<ReadHistory> {
  @override
  final int typeId = 0;

  @override
  ReadHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReadHistory(
      bookId: fields[0] as int?,
      thumbnail: fields[1] as String?,
      chapterNum: fields[2] as int,
      bookName: fields[3] as String?,
      detail: fields[4] as String?,
      readOffset: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReadHistory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.chapterNum)
      ..writeByte(3)
      ..write(obj.bookName)
      ..writeByte(4)
      ..write(obj.detail)
      ..writeByte(5)
      ..write(obj.readOffset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
