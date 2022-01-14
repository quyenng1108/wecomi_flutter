// To parse this JSON data, do
//
//     final groupPost = groupPostFromJson(jsonString);

import 'dart:convert';

GroupPost groupPostFromJson(String str) => GroupPost.fromJson(json.decode(str));

String groupPostToJson(GroupPost data) => json.encode(data.toJson());

class GroupPost {
    GroupPost({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int? count;
    String? next;
    dynamic previous;
    List<PostData>? results;

    factory GroupPost.fromJson(Map<String, dynamic> json) => GroupPost(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<PostData>.from(json["results"].map((x) => PostData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class PostData {
    PostData({
        this.id,
        this.user,
        this.group,
        this.content,
        this.likeCount,
        this.shareCount,
        this.dateAdded,
        this.dateModified,
        this.isDeleted,
        this.imageUrl,
        this.userId,
        this.groupId,
        this.avatar,
        this.commentCount,
    });

    int? id;
    String? user;
    String? group;
    String? content;
    int? likeCount = 0;
    int? shareCount = 0;
    DateTime? dateAdded;
    DateTime? dateModified;
    bool? isDeleted;
    String? imageUrl;
    int? userId;
    int? groupId;
    String? avatar;
    int? commentCount = 0;

    factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["id"],
        user: json["user"],
        group: json["group"],
        content: json["content"],
        likeCount: json["like_count"],
        shareCount: json["share_count"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: DateTime.parse(json["date_modified"]),
        isDeleted: json["is_deleted"],
        imageUrl: json["image_url"],
        userId: json["user_id"],
        groupId: json["group_id"],
        avatar: json["avatar"],
        commentCount: json["comment_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "group": group,
        "content": content,
        "like_count": likeCount,
        "share_count": shareCount,
        "date_added": dateAdded!.toIso8601String(),
        "date_modified": dateModified!.toIso8601String(),
        "is_deleted": isDeleted,
        "image_url": imageUrl,
        "user_id": userId,
        "group_id": groupId,
        "avatar": avatar,
        "comment_count": commentCount,
    };
}
