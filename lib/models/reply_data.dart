// To parse this JSON data, do
//
//     final replyData = replyDataFromJson(jsonString);

import 'dart:convert';

import 'package:wecomi_flutter/models/post_comment.dart';

ReplyData replyDataFromJson(String str) => ReplyData.fromJson(json.decode(str));

String replyDataToJson(ReplyData data) => json.encode(data.toJson());

class ReplyData {
    ReplyData({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int? count;
    dynamic next;
    dynamic previous;
    List<Reply>? results;

    factory ReplyData.fromJson(Map<String, dynamic> json) => ReplyData(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Reply>.from(json["results"].map((x) => Reply.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}
