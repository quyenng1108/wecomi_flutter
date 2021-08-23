import 'dart:convert';

List<HotKeyword> hotKeywordFromJson(String str) => List<HotKeyword>.from(json.decode(str).map((x) => HotKeyword.fromJson(x)));

String hotKeywordToJson(List<HotKeyword> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotKeyword {
    HotKeyword({
        this.trendingWord,
    });

    String? trendingWord;

    factory HotKeyword.fromJson(Map<String, dynamic> json) => HotKeyword(
        trendingWord: json["trendingWord"],
    );

    Map<String, dynamic> toJson() => {
        "trendingWord": trendingWord,
    };
}
