import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
    Category({
        this.categoryId,
        this.categoryName,
        this.parentCategoryId,
        this.level,
    });

    int? categoryId;
    String? categoryName;
    int? parentCategoryId;
    int? level;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["CategoryId"],
        categoryName: json["CategoryName"],
        parentCategoryId: json["ParentCategoryId"],
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "CategoryName": categoryName,
        "ParentCategoryId": parentCategoryId,
        "level": level,
    };
}
