// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Book({
    this.bookUuid,
    this.bookName,
    this.bookDescription,
    this.adultLimit,
    this.bookSexId,
    this.rating,
    this.likeNo,
    this.followNo,
    this.isEnable,
    this.commentAllowed,
    this.authorAccountId,
    this.authorNickName,
    this.category,
    this.lastUpdateTime,
    this.updateStatus,
    this.bookCoverImg,
  });

  String? bookUuid;
  String? bookName;
  String? bookDescription;
  int? adultLimit;
  int? bookSexId;
  double? rating;
  int? likeNo;
  int? followNo;
  bool? isEnable;
  bool? commentAllowed;
  int? authorAccountId;
  String? authorNickName;
  List<Category>? category;
  DateTime? lastUpdateTime;
  int? updateStatus;
  List<BookCoverImg>? bookCoverImg;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        bookUuid: json["BookUUID"],
        bookName: json["BookName"],
        bookDescription: json["BookDescription"],
        adultLimit: json["adultLimit"],
        bookSexId: json["bookSexId"],
        rating: json["Rating"].toDouble(),
        likeNo: json["LikeNo"],
        followNo: json["FollowNo"],
        isEnable: json["isEnable"],
        commentAllowed: json["commentAllowed"],
        authorAccountId: json["authorAccountId"],
        authorNickName: json["authorNickName"],
        category: List<Category>.from(
            json["Category"].map((x) => Category.fromJson(x))),
        lastUpdateTime: DateTime.parse(json["lastUpdateTime"]),
        updateStatus: json["updateStatus"],
        bookCoverImg: json["BookCover_Img"] != null
            ? List<BookCoverImg>.from(
                json["BookCover_Img"].map((x) => BookCoverImg.fromJson(x)))
            : <BookCoverImg>[],
      );

  Map<String, dynamic> toJson() => {
        "BookUUID": bookUuid,
        "BookName": bookName,
        "BookDescription": bookDescription,
        "adultLimit": adultLimit,
        "bookSexId": bookSexId,
        "Rating": rating,
        "LikeNo": likeNo,
        "FollowNo": followNo,
        "isEnable": isEnable,
        "commentAllowed": commentAllowed,
        "authorAccountId": authorAccountId,
        "authorNickName": authorNickName,
        "Category": List<dynamic>.from(category!.map((x) => x.toJson())),
        "lastUpdateTime": lastUpdateTime!.toIso8601String(),
        "updateStatus": updateStatus,
        "BookCover_Img":
            List<dynamic>.from(bookCoverImg!.map((x) => x.toJson())),
      };
}

class BookCoverImg {
  BookCoverImg({
    this.imgId,
    this.imgUrl,
  });

  int? imgId;
  String? imgUrl;

  factory BookCoverImg.fromJson(Map<String, dynamic> json) => BookCoverImg(
        imgId: json["imgId"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "imgId": imgId,
        "imgUrl": imgUrl,
      };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
  });

  int? categoryId;
  String? categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["CategoryId"],
        categoryName: json["CategoryName"],
      );

  Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "CategoryName": categoryName,
      };
}
