// To parse this JSON data, do
//
//     final bookDetail = bookDetailFromJson(jsonString);

import 'dart:convert';

List<BookDetail> bookDetailFromJson(String str) => List<BookDetail>.from(json.decode(str).map((x) => BookDetail.fromJson(x)));

String bookDetailToJson(List<BookDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookDetail {
    BookDetail({
        this.chapterId,
        this.chapterName,
        this.adultLimit,
        this.likeNo,
        this.commentNo,
        this.publishDate,
        this.isPremium,
    });

    String? chapterId;
    String? chapterName;
    int? adultLimit;
    int? likeNo;
    int? commentNo;
    DateTime? publishDate;
    bool? isPremium;

    factory BookDetail.fromJson(Map<String, dynamic> json) => BookDetail(
        chapterId: json["ChapterId"],
        chapterName: json["ChapterName"],
        adultLimit: json["adultLimit"],
        likeNo: json["LikeNo"],
        commentNo: json["CommentNo"] ?? 0,
        publishDate: DateTime.parse(json["PublishDate"]),
        isPremium: json["isPremium"],
    );

    Map<String, dynamic> toJson() => {
        "ChapterId": chapterId,
        "ChapterName": chapterName,
        "adultLimit": adultLimit,
        "LikeNo": likeNo,
        "CommentNo": commentNo,
        "PublishDate": publishDate!.toIso8601String(),
        "isPremium": isPremium,
    };
}
