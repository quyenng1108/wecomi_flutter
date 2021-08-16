import 'package:equatable/equatable.dart';

class BookDetails extends Equatable {
  final int bookId;
  final String bookUUID;
  final String bookName;
  final String bookDescription;
  final int adultLimit;
  final int bookSexId;
  final double rating;
  final int likeNo;
  final int followNo;
  final int isEnable;
  final double commentAllowed;
  final int authorAccountId;
  final DateTime updateStatus;
  final DateTime lastUpdateTime;
  const BookDetails({
    required this.bookId,
    required this.bookUUID,
    required this.bookName,
    required this.bookDescription,
    required this.adultLimit,
    required this.bookSexId,
    required this.rating,
    required this.likeNo,
    required this.followNo,
    required this.isEnable,
    required this.commentAllowed,
    required this.authorAccountId,
    required this.updateStatus,
    required this.lastUpdateTime,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        bookId,
        bookUUID,
        bookName,
        bookDescription,
        adultLimit,
        bookSexId,
        rating,
        likeNo,
        followNo,
        isEnable,
        commentAllowed,
        authorAccountId,
        updateStatus,
        lastUpdateTime
      ];
  factory BookDetails.fromJson(Map<String, dynamic> jsonObject) {
    return BookDetails(
        bookId: jsonObject["bookId"],
        bookUUID: jsonObject["bookUUID"],
        bookName: jsonObject["bookName"],
        bookDescription: jsonObject["bookDescription"],
        adultLimit: jsonObject["adultLimit"],
        bookSexId: jsonObject["bookSexId"],
        rating: jsonObject["rating"],
        likeNo: jsonObject["likeNo"],
        followNo: jsonObject["followNo"],
        isEnable: jsonObject["isEnable"],
        commentAllowed: jsonObject["commentAllowed"],
        authorAccountId: jsonObject["authorAccountId"],
        updateStatus: jsonObject["updateStatus"],
        lastUpdateTime: jsonObject["lastUpdateTime"]);
  }
}
