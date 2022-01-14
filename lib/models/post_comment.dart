// To parse this JSON data, do
//
//     final postComment = postCommentFromJson(jsonString);

import 'dart:convert';

PostComment postCommentFromJson(String str) => PostComment.fromJson(json.decode(str));

String postCommentToJson(PostComment data) => json.encode(data.toJson());

class PostComment {
    PostComment({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int? count;
    dynamic next;
    dynamic previous;
    List<CommentData>? results;

    factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<CommentData>.from(json["results"].map((x) => CommentData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class CommentData {
    CommentData({
        this.id,
        this.book,
        this.chapter,
        this.user,
        this.content,
        this.reply,
        this.dateModified,
        this.dateAdded,
        this.likeCount = 0,
        this.isDeleted,
        this.name,
        this.replyCount = 0,
        this.avatar = '',
    });

    int? id;
    dynamic book;
    dynamic chapter;
    int? user;
    String? content;
    List<Reply>? reply;
    DateTime? dateModified;
    DateTime? dateAdded;
    int? likeCount;
    bool? isDeleted;
    String? name;
    int? replyCount;
    String? avatar;

    factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json["id"],
        book: json["book"],
        chapter: json["chapter"],
        user: json["user"],
        content: json["content"],
        reply: List<Reply>.from(json["reply"].map((x) => Reply.fromJson(x))),
        dateModified: DateTime.parse(json["date_modified"]),
        dateAdded: DateTime.parse(json["date_added"]),
        likeCount: json["like_count"],
        isDeleted: json["is_deleted"],
        name: json["name"],
        replyCount: json["reply_count"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "book": book,
        "chapter": chapter,
        "user": user,
        "content": content,
        "reply": List<dynamic>.from(reply!.map((x) => x.toJson())),
        "date_modified": dateModified!.toIso8601String(),
        "date_added": dateAdded!.toIso8601String(),
        "like_count": likeCount,
        "is_deleted": isDeleted,
        "name": name,
        "reply_count": replyCount,
        "avatar": avatar ?? '',
    };
}

class Reply {
    Reply({
        this.id,
        this.comment,
        this.user,
        this.reply,
        this.likeCount,
        this.dateModified,
        this.dateAdded,
        this.isDeleted,
        this.userName,
        this.avatar,
        this.userId,
        this.level,
    });

    int? id;
    int? comment;
    int? user;
    String? reply;
    int? likeCount;
    DateTime? dateModified;
    DateTime? dateAdded;
    bool? isDeleted;
    String? userName;
    String? avatar;
    int? userId;
    String? level;

    factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"] == null ? null : json["id"],
        comment: json["comment"] == null ? null : json["comment"],
        user: json["user"] == null ? null : json["user"],
        reply: json["reply"],
        likeCount: json["like_count"] == null ? null : json["like_count"],
        dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
        dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
        isDeleted: json["is_deleted"],
        userName: json["user_name"] == null ? null : json["user_name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        userId: json["user_id"] == null ? null : json["user_id"],
        level: json["level"] == null ? null : json["level"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "comment": comment == null ? null : comment,
        "user": user == null ? null : user,
        "reply": reply,
        "like_count": likeCount == null ? null : likeCount,
        "date_modified": dateModified == null ? null : dateModified!.toIso8601String(),
        "date_added": dateAdded == null ? null : dateAdded!.toIso8601String(),
        "is_deleted": isDeleted,
        "user_name": userName == null ? null : userName,
        "avatar": avatar == null ? null : avatar,
        "user_id": userId == null ? null : userId,
        "level": level == null ? null : level,
    };
}
