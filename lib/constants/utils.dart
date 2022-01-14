import 'package:hive_flutter/hive_flutter.dart';
import 'package:wecomi_flutter/models/followed_book.dart';
import 'package:wecomi_flutter/models/followed_book_model.dart';
import 'package:wecomi_flutter/models/read_history.dart';

class Utils {
  static String timeElasped(DateTime datetime) {
    var date = DateTime.now();
    var diff = date.difference(datetime).inSeconds;
    if (diff < 60) {
      return '${date.difference(datetime).inSeconds} giây trước';
    } else if (60 <= diff && diff < 3600) {
      return '${(date.difference(datetime).inSeconds / 60).floor()} phút trước';
    } else if (3600 <= diff && diff < 86400) {
      return '${(date.difference(datetime).inSeconds / 3600).floor()} giờ trước';
    } else if (86400 <= diff && diff < 604800) {
      return '${(date.difference(datetime).inSeconds / 86400).floor()} ngày trước';
    } else if (604800 <= diff && diff < 2592000) {
      return '${(date.difference(datetime).inDays / 7).floor()} tuần trước';
    } else if (259200 <= diff && diff < 31556952) {
      return '${(date.difference(datetime).inDays / 30).floor()} tháng trước';
    } else if (diff >= 31556952) {
      return '${(date.difference(datetime).inDays / 365).floor()} năm trước';
    } else {
      return '';
    }
    // if(var diff = date.difference(datetime).inMinutes;)
  }

  static Box<ReadHistory> getReadHistory() {
    return Hive.box<ReadHistory>('readHistory');
  }

  static void deleteDb() {
    var box = Hive.box<ReadHistory>('readHistory');
    box.clear();
  }

  static Box<FollowedBook> getFollowedBook() {
    return Hive.box<FollowedBook>('followedBook');
  }

  static void deleteDbFollowed() {
    var box = Hive.box<FollowedBook>('followedBook');
    box.clear();
  }
}
