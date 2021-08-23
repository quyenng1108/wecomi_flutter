import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/models/book_detail.dart';
import 'package:wecomi_flutter/view_models/service_view_models/book_detail_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/chapter_provider.dart';
import 'package:wecomi_flutter/views/chapter_detail/chapter_detail_screen.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

List test = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
    BookDetailProvider bookDetailProvider =
        Provider.of<BookDetailProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      bookDetailProvider.getBookDetail();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();

    super.dispose();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    ChapterProvider chapterProvider =
        Provider.of<ChapterProvider>(context, listen: false);
    return Consumer<BookDetailProvider>(
        builder: (context, bookDetailProvider, child) => Scaffold(
              body: Column(
                children: [
                  bookDetailProvider.bookDetailList.length == 0
                      ? CupertinoActivityIndicator()
                      : Expanded(
                          child: ListView.builder(
                            reverse: true,
                              itemCount:
                                  bookDetailProvider.bookDetailList.length,
                              itemBuilder: (context, index) => Column(
                                    children: [
                                      Text(bookDetailProvider
                                          .bookDetailList[index].chapterName!),
                                      GestureDetector(
                                        onTap: (){
                                          chapterProvider
                                              .getChapterData(
                                                  bookDetailProvider
                                                      .bookDetailList[index]
                                                      .chapterId!,
                                                  0)
                                              .then((value) => Navigator.of(
                                                      context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChapterDetailScreen(
                                                              bookDetailList:
                                                                  bookDetailProvider
                                                                      .bookDetailList,
                                                              chapterIndex:
                                                                  index)))
                                                  .then((value) => print(
                                                      bookDetailProvider
                                                          .bookDetailList[index]
                                                          .chapterId)));

                                        },
                                        child: Container(
                                          height: 100,
                                          child: Text(bookDetailProvider
                                              .bookDetailList[index]
                                              .chapterId!),
                                        ),
                                      ),
                                    ],
                                  ))),
                ],
              ),
            ));
  }
}
