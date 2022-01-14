// // To parse this JSON data, do
// //
// //     final genreList = genreListFromJson(jsonString);

// import 'dart:convert';

// GenreList genreListFromJson(String str) => GenreList.fromJson(json.decode(str));

// String genreListToJson(GenreList data) => json.encode(data.toJson());

// class GenreList {
//     GenreList({
//         this.count,
//         this.next,
//         this.previous,
//         this.results,
//     });

//     int count;
//     String next;
//     dynamic previous;
//     List<Result> results;

//     factory GenreList.fromJson(Map<String, dynamic> json) => GenreList(
//         count: json["count"],
//         next: json["next"],
//         previous: json["previous"],
//         results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "count": count,
//         "next": next,
//         "previous": previous,
//         "results": List<dynamic>.from(results.map((x) => x.toJson())),
//     };
// }

// class Result {
//     Result({
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
//         this.rate,
//         this.isVip,
//         this.isFull,
//         this.countComment,
//     });

//     int id;
//     String title;
//     bool isEnable;
//     dynamic thumbnail;
//     String description;
//     Author author;
//     DateTime dateModified;
//     DateTime dateAdded;
//     Sex sex;
//     Status status;
//     Type type;
//     int likeCount;
//     int viewCount;
//     String rate;
//     bool isVip;
//     bool isFull;
//     int countComment;

//     factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["id"],
//         title: json["title"],
//         isEnable: json["is_enable"],
//         thumbnail: json["thumbnail"],
//         description: json["description"],
//         author: authorValues.map[json["author"]],
//         dateModified: DateTime.parse(json["date_modified"]),
//         dateAdded: DateTime.parse(json["date_added"]),
//         sex: sexValues.map[json["sex"]],
//         status: statusValues.map[json["status"]],
//         type: typeValues.map[json["type"]],
//         likeCount: json["like_count"],
//         viewCount: json["view_count"],
//         rate: json["rate"],
//         isVip: json["is_vip"],
//         isFull: json["is_full"],
//         countComment: json["count_comment"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "is_enable": isEnable,
//         "thumbnail": thumbnail,
//         "description": description,
//         "author": authorValues.reverse[author],
//         "date_modified": dateModified.toIso8601String(),
//         "date_added": dateAdded.toIso8601String(),
//         "sex": sexValues.reverse[sex],
//         "status": statusValues.reverse[status],
//         "type": typeValues.reverse[type],
//         "like_count": likeCount,
//         "view_count": viewCount,
//         "rate": rate,
//         "is_vip": isVip,
//         "is_full": isFull,
//         "count_comment": countComment,
//     };
// }

// enum Author { SONA_COMIC }

// final authorValues = EnumValues({
//     "SONA Comic": Author.SONA_COMIC
// });

// enum Sex { MALE }

// final sexValues = EnumValues({
//     "male": Sex.MALE
// });

// enum Status { NEW }

// final statusValues = EnumValues({
//     "new": Status.NEW
// });

// enum Type { COMIC }

// final typeValues = EnumValues({
//     "comic": Type.COMIC
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
