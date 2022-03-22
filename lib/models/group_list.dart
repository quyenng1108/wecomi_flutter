// To parse this JSON data, do
//
//     final groupList = groupListFromJson(jsonString);

import 'dart:convert';

GroupList groupListFromJson(String str) => GroupList.fromJson(json.decode(str));

String groupListToJson(GroupList data) => json.encode(data.toJson());

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

class GroupList {
    GroupList({
        this.code,
        this.data,
        this.msg,
        this.status,
    });

    int? code;
    Data? data;
    String? msg;
    String? status;

    factory GroupList.fromJson(Map<String, dynamic> json) => GroupList(
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
        this.postCount,
        this.memberCount,
        this.description,
        this.dateAdded,
        this.dateModified,
        this.isDeleted,
        this.avatar,
        this.joined,
    });

    int? id;
    String? name;
    int? postCount;
    int? memberCount;
    String? description;
    DateTime? dateAdded;
    DateTime? dateModified;
    bool? isDeleted;
    String? avatar;
    bool? joined;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        postCount: json["post_count"],
        memberCount: json["member_count"],
        description: json["description"] == null ? null : json["description"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: DateTime.parse(json["date_modified"]),
        isDeleted: json["is_deleted"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        joined: json["joined"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "post_count": postCount,
        "member_count": memberCount,
        "description": description == null ? null : description,
        "date_added": dateAdded!.toIso8601String(),
        "date_modified": dateModified!.toIso8601String(),
        "is_deleted": isDeleted,
        "avatar": avatar == null ? null : avatar,
        "joined": joined,
    };
}
