// To parse this JSON data, do
//
//     final chapterByBookUuid = chapterByBookUuidFromJson(jsonString);

import 'dart:convert';

ChapterByBookUuid chapterByBookUuidFromJson(String str) => ChapterByBookUuid.fromJson(json.decode(str));

String chapterByBookUuidToJson(ChapterByBookUuid data) => json.encode(data.toJson());

class ChapterByBookUuid {
    ChapterByBookUuid({
        this.chapter,
    });

    List<Chapter>? chapter;

    factory ChapterByBookUuid.fromJson(Map<String, dynamic> json) => ChapterByBookUuid(
        chapter: List<Chapter>.from(json["chapter"].map((x) => Chapter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "chapter": List<dynamic>.from(chapter!.map((x) => x.toJson())),
    };
}

class Chapter {
    Chapter({
        this.id,
        this.book,
        this.number,
        this.title,
        this.thumbnail,
        this.dateModified,
        this.dateAdded,
        this.likeCount,
        this.isDeleted,
    });

    int? id;
    int? book;
    int? number;
    String? title;
    String? thumbnail;
    DateTime? dateModified;
    DateTime? dateAdded;
    int? likeCount;
    bool? isDeleted;

    factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        book: json["book"],
        number: json["number"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        dateModified: DateTime.parse(json["date_modified"]),
        dateAdded: DateTime.parse(json["date_added"]),
        likeCount: json["like_count"],
        isDeleted: json["is_deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "book": book,
        "number": number,
        "title": title,
        "thumbnail": thumbnail,
        "date_modified": dateModified!.toIso8601String(),
        "date_added": dateAdded!.toIso8601String(),
        "like_count": likeCount,
        "is_deleted": isDeleted,
    };
}
