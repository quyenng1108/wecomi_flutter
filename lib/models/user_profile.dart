// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    UserProfile({
        this.id,
        this.fullName,
        this.phoneNumber,
        this.email,
        this.gender,
        this.userType,
        this.level,
        this.coin,
        this.point,
        this.avatar,
        this.post,
        this.countFollowing,
        this.countFollower,
    });

    int? id;
    String? fullName;
    String? phoneNumber;
    String? email;
    String? gender;
    int? userType;
    String? level;
    int? coin;
    int? point;
    String? avatar;
    List<Post>? post;
     int? countFollowing;
    int? countFollower;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        gender: json["gender"],
        userType: json["user_type"],
        level: json["level"],
        coin: json["coin"],
        point: json["point"],
        avatar: json["avatar"],
        post: json["post"] == [] ? [] : List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
        countFollowing: json["count_following"],
        countFollower: json["count_follower"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "email": email,
        "gender": gender,
        "user_type": userType,
        "level": level,
        "coin": coin,
        "point": point,
        "avatar": avatar,
        "post": List<dynamic>.from(post!.map((x) => x.toJson())),
        "count_following": countFollowing,
        "count_follower": countFollower,
    };
}


class Post {
    Post({
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
    int? likeCount;
    int? shareCount;
    DateTime? dateAdded;
    DateTime? dateModified;
    bool? isDeleted;
    String? imageUrl;
    int? userId;
    int? groupId;
    String? avatar;
    int? commentCount;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
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

