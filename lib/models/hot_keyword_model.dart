// To parse this JSON data, do
//
//     final hotKeyword = hotKeywordFromJson(jsonString);

import 'dart:convert';

HotKeyword hotKeywordFromJson(String str) => HotKeyword.fromJson(json.decode(str));

String hotKeywordToJson(HotKeyword data) => json.encode(data.toJson());

class HotKeyword {
    HotKeyword({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int? count;
    dynamic next;
    dynamic previous;
    List<Result>? results;

    factory HotKeyword.fromJson(Map<String, dynamic> json) => HotKeyword(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.id,
        this.user,
        this.text,
        this.point,
        this.dateModified,
        this.dateAdded,
        this.isDeleted,
        this.tag,
    });

    int? id;
    dynamic user;
    String? text;
    int? point;
    DateTime? dateModified;
    DateTime? dateAdded;
    bool? isDeleted;
    String? tag;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        user: json["user"],
        text: json["text"],
        point: json["point"],
        dateModified: DateTime.parse(json["date_modified"]),
        dateAdded: DateTime.parse(json["date_added"]),
        isDeleted: json["is_deleted"],
        tag: json["tag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "text": text,
        "point": point,
        "date_modified": dateModified!.toIso8601String(),
        "date_added": dateAdded!.toIso8601String(),
        "is_deleted": isDeleted,
        "tag": tag,
    };
}
