// To parse this JSON data, do
//
//     final booksByCategory = booksByCategoryFromJson(jsonString);

import 'dart:convert';

List<BooksByCategory> booksByCategoryFromJson(String str) => List<BooksByCategory>.from(json.decode(str).map((x) => BooksByCategory.fromJson(x)));

String booksByCategoryToJson(List<BooksByCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BooksByCategory {
    BooksByCategory({
        this.bookUuid,
        this.bookName,
        this.rating,
        this.authorAccountId,
        this.authorNick,
        this.bookSexId,
        this.imgUrl,
        this.lastUpdateTime,
        this.categoryList,
        this.numberOfChapter,
    });

    String? bookUuid;
    String? bookName;
    String? rating;
    int? authorAccountId;
    String? authorNick;
    int? bookSexId;
    String? imgUrl;
    String? lastUpdateTime;
    String? categoryList;
    int? numberOfChapter;

    factory BooksByCategory.fromJson(Map<String, dynamic> json) => BooksByCategory(
        bookUuid: json["BookUUID"],
        bookName: json["BookName"],
        rating: json["Rating"],
        authorAccountId: json["authorAccountId"],
        authorNick: json["AuthorNick"],
        bookSexId: json["BookSexId"],
        imgUrl: json["imgUrl"],
        lastUpdateTime: json["lastUpdateTime"],
        categoryList: json["CategoryList"],
        numberOfChapter: json["NumberOfChapter"],
    );

    Map<String, dynamic> toJson() => {
        "BookUUID": bookUuid,
        "BookName": bookName,
        "Rating": rating,
        "authorAccountId": authorAccountId,
        "AuthorNick": authorNick,
        "BookSexId": bookSexId,
        "imgUrl": imgUrl,
        "lastUpdateTime": lastUpdateTime,
        "CategoryList": categoryList,
        "NumberOfChapter": numberOfChapter,
    };
}
