// To parse this JSON data, do
//
//     final chapterByBookUuid = chapterByBookUuidFromJson(jsonString);

import 'dart:convert';

List<ChapterByBookUuid> chapterByBookUuidFromJson(String str) => List<ChapterByBookUuid>.from(json.decode(str).map((x) => ChapterByBookUuid.fromJson(x)));

String chapterByBookUuidToJson(List<ChapterByBookUuid> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChapterByBookUuid {
    ChapterByBookUuid({
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

    factory ChapterByBookUuid.fromJson(Map<String, dynamic> json) => ChapterByBookUuid(
        chapterId: json["ChapterId"],
        chapterName: json["ChapterName"],
        adultLimit: json["adultLimit"],
        likeNo: json["LikeNo"],
        commentNo: json["CommentNo"],
        publishDate: DateTime.parse(json["PublishDate"]),
        isPremium: json["isPremium"],
    );

    Map<String, dynamic> toJson() => {
        "ChapterId": chapterId,
        "ChapterName": chapterName,
        "adultLimit": adultLimit,
        "LikeNo": likeNo,
        "CommentNo": commentNo,
        "PublishDate": publishDate.toString(),
        "isPremium": isPremium,
    };
}
