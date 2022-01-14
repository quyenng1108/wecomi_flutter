// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
    Category({
        this.code,
        this.data,
        this.msg,
        this.status,
    });

    int? code;
    Data? data;
    String? msg;
    String? status;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "data": data!.toJson(),
        "msg": msg,
        "status": status,
    };
}

class Data {
    Data({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int? count;
    dynamic next;
    dynamic previous;
    List<Result>? results;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        this.name,
        this.dateModified,
        this.dateAdded,
        this.isDeleted,
    });

    int? id;
    String? name;
    DateTime? dateModified;
    DateTime? dateAdded;
    bool? isDeleted;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        dateModified: DateTime.parse(json["date_modified"]),
        dateAdded: DateTime.parse(json["date_added"]),
        isDeleted: json["is_deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_modified": dateModified!.toIso8601String(),
        "date_added": dateAdded!.toIso8601String(),
        "is_deleted": isDeleted,
    };
}
