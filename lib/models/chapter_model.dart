// To parse this JSON data, do
//
//     final chapter = chapterFromJson(jsonString);

import 'dart:convert';

Chapter chapterFromJson(String str) => Chapter.fromJson(json.decode(str));
List<Chapter> chapterToList(String str) => List<Chapter>.from(json.decode(str).map((x) => Chapter.fromJson(x)));

String chapterToJson(Chapter data) => json.encode(data.toJson());

class Chapter {
    Chapter({
        this.totalRows,
        this.pageNo,
        this.rowsOfPage,
        this.data,
    });

    int? totalRows;
    int? pageNo;
    int? rowsOfPage;
    List<ChapterData>? data;

    factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        totalRows: json["totalRows"],
        pageNo: json["pageNo"],
        rowsOfPage: json["rowsOfPage"],
        data: json["data"] != null ? List<ChapterData>.from(json["data"].map((x) => ChapterData.fromJson(x))) : <ChapterData>[],
    );

    Map<String, dynamic> toJson() => {
        "totalRows": totalRows,
        "pageNo": pageNo,
        "rowsOfPage": rowsOfPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ChapterData {
    ChapterData({
        this.chapterId,
        this.chapterName,
        this.page,
        this.pageImgUrl,
        this.bookId,
        this.bookName,
    });

    String? chapterId;
    String? chapterName;
    int? page;
    String? pageImgUrl;
    int? bookId;
    String? bookName;

    factory ChapterData.fromJson(Map<String, dynamic> json) => ChapterData(
        chapterId: json["ChapterId"],
        chapterName: json["ChapterName"],
        page: json["Page"],
        pageImgUrl: json["PageImgUrl"],
        bookId: json["BookId"],
        bookName: json["BookName"],
    );

    Map<String, dynamic> toJson() => {
        "ChapterId": chapterId,
        "ChapterName": chapterName,
        "Page": page,
        "PageImgUrl": pageImgUrl,
        "BookId": bookId,
        "BookName": bookName,
    };
}
