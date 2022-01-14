import 'package:hive_flutter/hive_flutter.dart';
part 'read_history.g.dart';

@HiveType(typeId: 0)
class ReadHistory extends HiveObject {
  @HiveField(0)
  int? bookId;

  @HiveField(1)
  String? thumbnail;

  @HiveField(2)
  int chapterNum;

  @HiveField(3)
  String? bookName;

  @HiveField(4)
  String? detail;

  @HiveField(5)
  int readOffset;

  ReadHistory(
      {this.bookId,
      this.thumbnail,
      this.chapterNum = 1,
      this.bookName,
      this.detail,
      this.readOffset = 0});
}
