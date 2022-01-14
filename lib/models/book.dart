// // To parse this JSON data, do
// //
// //     final bookInfo = bookInfoFromJson(jsonString);

// import 'dart:convert';

// BookInfo bookInfoFromJson(String str) => BookInfo.fromJson(json.decode(str));

// String bookInfoToJson(BookInfo data) => json.encode(data.toJson());

// class BookInfo {
//     BookInfo({
//         this.id,
//         this.title,
//         this.isEnable,
//         this.thumbnail,
//         this.description,
//         this.author,
//         this.dateModified,
//         this.dateAdded,
//         this.sex,
//         this.status,
//         this.type,
//         this.likeCount,
//         this.viewCount,
//         this.star,
//         this.isVip,
//         this.isFull,
//         this.chapter,
//         this.countChapterDownload,
//         this.tag,
//         this.countChapter,
//         this.countComment,
//         this.countFollow,
//     });

//     int? id;
//     String? title;
//     bool? isEnable;
//     String? thumbnail;
//     String? description;
//     String? author;
//     DateTime? dateModified;
//     DateTime? dateAdded;
//     String? sex;
//     String? status;
//     String? type;
//     int? likeCount;
//     int? viewCount;
//     int? star;
//     bool? isVip;
//     bool? isFull;
//     List<dynamic>? chapter;
//     int? countChapterDownload;
//     String? tag;
//     int? countChapter;
//     int? countComment;
//     int? countFollow;

//     factory BookInfo.fromJson(Map<String, dynamic> json) => BookInfo(
//         id: json["id"],
//         title: json["title"],
//         isEnable: json["is_enable"],
//         thumbnail: json["thumbnail"],
//         description: json["description"],
//         author: json["author"],
//         dateModified: DateTime.parse(json["date_modified"]),
//         dateAdded: DateTime.parse(json["date_added"]),
//         sex: json["sex"],
//         status: json["status"],
//         type: json["type"],
//         likeCount: json["like_count"],
//         viewCount: json["view_count"],
//         star: json["star"],
//         isVip: json["is_vip"],
//         isFull: json["is_full"],
//         chapter: List<dynamic>.from(json["chapter"].map((x) => x)),
//         countChapterDownload: json["count__chapter_download"],
//         tag: json["tag"],
//         countChapter: json["count_chapter"],
//         countComment: json["count_comment"],
//         countFollow: json["count_follow"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "is_enable": isEnable,
//         "thumbnail": thumbnail,
//         "description": description,
//         "author": author,
//         "date_modified": dateModified!.toIso8601String(),
//         "date_added": dateAdded!.toIso8601String(),
//         "sex": sex,
//         "status": status,
//         "type": type,
//         "like_count": likeCount,
//         "view_count": viewCount,
//         "star": star,
//         "is_vip": isVip,
//         "is_full": isFull,
//         "chapter": List<dynamic>.from(chapter!.map((x) => x)),
//         "count__chapter_download": countChapterDownload,
//         "tag": tag,
//         "count_chapter": countChapter,
//         "count_comment": countComment,
//         "count_follow": countFollow,
//     };
// }
