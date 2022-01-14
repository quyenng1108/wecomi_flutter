// To parse this JSON data, do
//
//     final comicByCategory = comicByCategoryFromJson(jsonString);

import 'dart:convert';

import 'package:wecomi_flutter/constants/api.dart';

ComicByCategory comicByCategoryFromJson(String str) => ComicByCategory.fromJson(json.decode(str));

String comicByCategoryToJson(ComicByCategory data) => json.encode(data.toJson());

class ComicByCategory {
    ComicByCategory({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int? count;
    dynamic next;
    dynamic previous;
    List<ComicDetail>? results;

    factory ComicByCategory.fromJson(Map<String, dynamic> json) => ComicByCategory(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] != null ? List<ComicDetail>.from(json["results"].map((x) => ComicDetail.fromJson(x))) : <ComicDetail>[],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class ComicDetail {
    ComicDetail({
        this.id,
        this.title,
        this.isEnable,
        this.thumbnail,
        this.description,
        this.author,
        this.dateModified,
        this.dateAdded,
        this.sex,
        this.status,
        this.type,
        this.likeCount,
        this.viewCount,
        this.star,
        this.isVip,
        this.tag,
        this.countChapter,
        this.countComment,
        this.countFollow,
    });

    int? id;
    String? title;
    bool? isEnable;
    String? thumbnail;
    String? description;
    String? author;
    DateTime? dateModified;
    DateTime? dateAdded;
    String? sex;
    String? status;
    String? type;
    int? likeCount;
    int? viewCount;
    int? star;
    bool? isVip;
    String? tag;
    int? countChapter;
    int? countComment;
    int? countFollow;

    factory ComicDetail.fromJson(Map<String, dynamic> json) => ComicDetail(
        id: json["id"],
        title: json["title"],
        isEnable: json["is_enable"],
        thumbnail: json["thumbnail"] == "" ? null : json["thumbnail"],
        description: json["description"],
        author: json["author"],
        dateModified: DateTime.parse(json["date_modified"]),
        dateAdded: DateTime.parse(json["date_added"]),
        sex: json["sex"],
        status: json["status"],
        type: json["type"],
        likeCount: json["like_count"],
        viewCount: json["view_count"],
        star: json["star"],
        isVip: json["is_vip"],
        tag: json["tag"],
        countChapter: json["count_chapter"],
        countComment: json["count_comment"] ?? 0,
        countFollow: json["count_follow"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_enable": isEnable,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "description": description,
        "author": author,
        "date_modified": dateModified!.toIso8601String(),
        "date_added": dateAdded!.toIso8601String(),
        "sex": sex,
        "status": status,
        "type": type,
        "like_count": likeCount,
        "view_count": viewCount,
        "star": star,
        "is_vip": isVip,
        "tag": tag,
        "count_chapter": countChapter,
        "count_comment": countComment,
        "count_follow": countFollow,
    };
}
