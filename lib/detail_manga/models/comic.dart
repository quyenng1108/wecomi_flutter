import 'dart:convert';

List<Comic> comicFromJson(String str) =>
    List<Comic>.from(json.decode(str).map((x) => Comic.fromJson(x)));

String comicToJson(List<Comic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comic {
  Comic({
    this.groupId,
    this.groupName,
    this.bookId,
    this.bookUuid,
    this.bookname,
    this.categoryId,
    this.categoryName,
    this.audltLimit,
    this.updateStatus,
    this.imgUrl,
  });

  String? groupId;
  String? groupName;
  int? bookId;
  String? bookUuid;
  String? bookname;
  int? categoryId;
  String? categoryName;
  int? audltLimit;
  int? updateStatus;
  String? imgUrl;

  factory Comic.fromJson(Map<String, dynamic> json) => Comic(
        groupId: json["groupId"],
        groupName: json["groupName"],
        bookId: json["BookId"],
        bookUuid: json["BookUUID"],
        bookname: json["Bookname"],
        categoryId: json["CategoryId"],
        categoryName: json["CategoryName"],
        audltLimit: json["audltLimit"],
        updateStatus: json["updateStatus"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "groupName": groupName,
        "BookId": bookId,
        "BookUUID": bookUuid,
        "Bookname": bookname,
        "CategoryId": categoryId,
        "CategoryName": categoryName,
        "audltLimit": audltLimit,
        "updateStatus": updateStatus,
        "imgUrl": imgUrl,
      };
}
