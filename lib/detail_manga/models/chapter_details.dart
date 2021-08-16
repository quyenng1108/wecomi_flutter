import 'package:equatable/equatable.dart';

class ChapterDetails extends Equatable {
  final int bookId;
  final String chapterId;
  final String chapterName;
  final int adultLimit;
  final int likeNo;
  final int commentNo;
  final int chapterStatus;
  final DateTime publishDate;
  final DateTime lastUpdateTime;
  final int isPremium;
  const ChapterDetails({
    required this.bookId,
    required this.chapterId,
    required this.chapterName,
    required this.adultLimit,
    required this.likeNo,
    required this.commentNo,
    required this.chapterStatus,
    required this.publishDate,
    required this.lastUpdateTime,
    required this.isPremium,
  });

  @override
  List<Object?> get props => [
        bookId,
        chapterId,
        chapterName,
        adultLimit,
        likeNo,
        commentNo,
        chapterStatus,
        publishDate,
        lastUpdateTime,
        isPremium
      ];
  factory ChapterDetails.fromJson(Map<String, dynamic> jsonObject) {
    return ChapterDetails(
        bookId: jsonObject["BookId"],
        chapterId: jsonObject["ChapterId"],
        chapterName: jsonObject["ChapterName"],
        adultLimit: jsonObject["adultLimit"],
        likeNo: jsonObject["LikeNo"],
        commentNo: jsonObject["CommentNo"],
        chapterStatus: jsonObject["ChapterStatus"],
        publishDate: jsonObject["PublishDate"],
        lastUpdateTime: jsonObject["lastUpdateTime"],
        isPremium: jsonObject["isPremium"]);
  }
}
