// To parse this JSON data, do
//
//     final chapter = chapterFromJson(jsonString);

import 'dart:convert';

import 'package:wecomi_flutter/constants/api.dart';

Chapter chapterFromJson(String str) => Chapter.fromJson(json.decode(str));

String chapterToJson(Chapter data) => json.encode(data.toJson());

class Chapter {
  Chapter({
    this.id,
    this.book,
    this.number,
    this.title,
    this.images,
  });

  int? id;
  int? book;
  int? number;
  String? title;
  List<Image>? images;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        book: json["book"],
        number: json["number"],
        title: json["title"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book": book,
        "number": number,
        "title": title,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    this.id,
    this.chapter,
    this.image,
    this.dateModified,
    this.dateAdded,
    this.isDeleted,
  });

  int? id;
  int? chapter;
  String? image;
  DateTime? dateModified;
  DateTime? dateAdded;
  bool? isDeleted;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        chapter: json["chapter"],
        image: "$apiUrlNoSlash${json["image"]}",
        dateModified: DateTime.parse(json["date_modified"]),
        dateAdded: DateTime.parse(json["date_added"]),
        isDeleted: json["is_deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapter": chapter,
        "image": image,
        "date_modified": dateModified!.toIso8601String(),
        "date_added": dateAdded!.toIso8601String(),
        "is_deleted": isDeleted,
      };
}
