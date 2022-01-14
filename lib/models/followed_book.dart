import 'package:hive/hive.dart';
part 'followed_book.g.dart';

@HiveType(typeId: 1)
class FollowedBook extends HiveObject{
    @HiveField(0)
  int? bookId;

  @HiveField(1)
  String? thumbnail;

  @HiveField(2)
  int star;

  @HiveField(3)
  String? bookName;

  @HiveField(4)
  String? detail;

  @HiveField(5)
  String? author;

   @HiveField(6)
  int numOfChapters;

   FollowedBook(
      {this.bookId,
      this.thumbnail,
      this.author,
      this.numOfChapters = 0,
      this.bookName,
      this.detail,
      this.star = 0});
}