// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followed_book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FollowedBookAdapter extends TypeAdapter<FollowedBook> {
  @override
  final int typeId = 1;

  @override
  FollowedBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FollowedBook(
      bookId: fields[0] as int?,
      thumbnail: fields[1] as String?,
      author: fields[5] as String?,
      numOfChapters: fields[6] as int,
      bookName: fields[3] as String?,
      detail: fields[4] as String?,
      star: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FollowedBook obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.star)
      ..writeByte(3)
      ..write(obj.bookName)
      ..writeByte(4)
      ..write(obj.detail)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.numOfChapters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowedBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
