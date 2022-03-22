// To parse this JSON data, do
//
//     final imagePost = imagePostFromJson(jsonString);

import 'dart:convert';

ImagePost imagePostFromJson(String str) => ImagePost.fromJson(json.decode(str));

String imagePostToJson(ImagePost data) => json.encode(data.toJson());

class ImagePost {
    ImagePost({
        this.id,
        this.chapter,
        this.image,
        this.dateModified,
        this.dateAdded,
        this.isDeleted,
    });

    int? id;
    dynamic chapter;
    String? image;
    DateTime? dateModified;
    DateTime? dateAdded;
    bool? isDeleted;

    factory ImagePost.fromJson(Map<String, dynamic> json) => ImagePost(
        id: json["id"],
        chapter: json["chapter"],
        image: json["image"],
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
