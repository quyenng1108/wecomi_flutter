// To parse this JSON data, do
//
//     final groupList = groupListFromJson(jsonString);

import 'dart:convert';

GroupList groupListFromJson(String str) => GroupList.fromJson(json.decode(str));

String groupListToJson(GroupList data) => json.encode(data.toJson());

class GroupList {
  GroupList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Groups>? results;

  factory GroupList.fromJson(Map<String, dynamic> json) => GroupList(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Groups>.from(json["results"].map((x) => Groups.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Groups {
  Groups({
    this.id,
    this.name,
    this.postCount,
    this.memberCount,
    this.description,
    this.dateAdded,
    this.dateModified,
    this.isDeleted,
    this.avatar,
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

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
        id: json["id"],
        name: json["name"],
        postCount: json["post_count"],
        memberCount: json["member_count"],
        description: json["description"] == null ? null : json["description"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: DateTime.parse(json["date_modified"]),
        isDeleted: json["is_deleted"],
                avatar: json["avatar"],

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
        "avatar": avatar,
    };
}

