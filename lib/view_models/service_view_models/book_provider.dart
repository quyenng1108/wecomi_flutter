// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:wecomi_flutter/models/book.dart';

// class BookProvider with ChangeNotifier {
//   String errorMessage = '';
//   bool isLoading = true;
//   showProgress() {
//     if (isLoading) {
//       return;
//     }
//     isLoading = true;
//     notifyListeners();
//   }

//   dismissProgress() {
//     if (!isLoading) {
//       return;
//     }
//     isLoading = false;
//     notifyListeners();
//   }

//   Future<BookInfo> fetBook(String bookUuid) async {
//     String url =
//         "http://117.103.207.22:8082/book/bookGetInfoGeneral?bookuuid=$bookUuid";
//     showProgress();
//     Response res = await Dio().get(url,
//         options: Options(headers: {"Content-Type": "application/json"}));
//     final bookInfo = bookInfoFromJson(res.data);
//     // book = List<Book>.from(res.data.map((i) => Book.fromJson(i)));
//     notifyListeners();
//     dismissProgress();
//     return bookInfo;
//   }

//   // Future
// }
