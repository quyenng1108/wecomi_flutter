import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/models/book_detail.dart';
import 'package:wecomi_flutter/models/getchapter_byBookuuid.dart';
import 'package:wecomi_flutter/models/read_history.dart';
import 'package:wecomi_flutter/view_models/service_view_models/chapter_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/comic_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/read_history_provider.dart';
import 'package:wecomi_flutter/views/account/account_screen.dart';
import 'package:wecomi_flutter/views/login/login_screen.dart';
import 'package:wecomi_flutter/views/main_screen.dart';

class ChapterDetailScreen extends StatefulWidget {
  ChapterDetailScreen(
      {required this.bookDetailList,
      required this.chapterIndex,
      required this.readHistory,
      this.offset = 0});
  final List<Chapter> bookDetailList;
  final int chapterIndex;
  final ReadHistory readHistory;
  double offset;
  @override
  _ChapterDetailScreenState createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ChapterProvider chapterProvider =
          Provider.of<ChapterProvider>(context, listen: false);
      chapterProvider.removeChapterList();
      chapterProvider
          .getChapterData(widget.bookDetailList[widget.chapterIndex].id!, 0)
          .then((value) {
        Future.delayed(Duration(
          milliseconds: 500,
        )).then((value) {
        
            _scrollController.jumpTo(widget.offset);
        });
      });
    });
    // ChapterProvider chapterProvider =
    //     Provider.of<ChapterProvider>(context, listen: false);
    // print(chapterProvider.chapterList.length);

    // _scrollController.addListener(() {
    //   // print("?");
    //   if (_scrollController.position.userScrollDirection ==
    //       ScrollDirection.reverse) {
    //     chapterProvider.dismissAppBar();
    //   }
    //   if (_scrollController.position.pixels <
    //       MediaQuery.of(context).size.height * 0.1428) {
    //     chapterProvider.showAppBar();
    //   }
    // });
  }

  int _index = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
  Future<void> _getMoreData(int chapterId, int choice) async {
    ChapterProvider chapterProvider =
        Provider.of<ChapterProvider>(context, listen: false);
    chapterProvider.showProgress();
    chapterProvider.getChapterData(chapterId, choice);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _refreshIndex = widget.chapterIndex;
    int _loadIndex = widget.chapterIndex;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.1428),
          child: Consumer<ChapterProvider>(
            builder: (context, chapterProvider, child) =>
                chapterProvider.isLoading || chapterProvider.chapterList.isEmpty
                    ? Container()
                    : AnimatedContainer(
                        height: chapterProvider.isVisible ? height * 0.1428 : 0,
                        duration: Duration(milliseconds: 200),
                        child: AppBar(
                          // brightness: Brightness.light,
                          titleSpacing: 0,
                          backgroundColor: Colors.black.withOpacity(.9),
                          centerTitle: true,
                          title: Text(
                            chapterProvider
                                .chapterList[chapterProvider.titleIndex].title!,
                            style: extraLargeMediumBodyTextStyle.copyWith(
                                color: Colors.white),
                          ),
                          leading: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // chapterProvider.removeChapterList();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
          ),
        ),
        body: Consumer<ChapterProvider>(
          builder: (context, chapterProvider, child) => chapterProvider
                      .chapterList.length ==
                  0
              ? chapterProvider.isLoading
                  ? Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Khong co data"),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Get back"))
                        ],
                      ),
                    )
              : Scrollbar(
                  child: SmartRefresher(
                    onRefresh: () {
                      _refreshIndex++;
                      _getMoreData(widget.bookDetailList[_refreshIndex].id!, 1)
                          .then((value) => chapterProvider.flag == true
                              ? _refreshController.refreshCompleted()
                              : _refreshController.refreshFailed());
                      var chapterNum = widget
                          .bookDetailList[_refreshIndex].title!
                          .split(' ')[1];
                      if (widget.readHistory.chapterNum !=
                          int.parse(chapterNum)) {
                        ReadHistory readHistory = ReadHistory(
                            bookId: widget.readHistory.bookId,
                            chapterNum: int.parse(chapterNum),
                            thumbnail: widget.readHistory.thumbnail,
                            bookName: widget.readHistory.bookName,
                            detail: widget.readHistory.detail);
                        context
                            .read<ReadHistoryProvider>()
                            .saveReadHistory(readHistory);
                      }
                    },
                    onLoading: () {
                      _loadIndex--;
                      _getMoreData(widget.bookDetailList[_loadIndex].id!, 2)
                          .then((value) => chapterProvider.flag == true
                              ? _refreshController.loadComplete()
                              : _refreshController.loadNoData());
                      var chapterNum = widget.bookDetailList[_loadIndex].title!
                          .split(' ')[1];
                      if (widget.readHistory.chapterNum !=
                          int.parse(chapterNum)) {
                        ReadHistory readHistory = ReadHistory(
                            bookId: widget.readHistory.bookId,
                            chapterNum: int.parse(chapterNum),
                            thumbnail: widget.readHistory.thumbnail,
                            bookName: widget.readHistory.bookName,
                            detail: widget.readHistory.detail);
                        context
                            .read<ReadHistoryProvider>()
                            .saveReadHistory(readHistory);
                      }
                    },
                    enablePullDown: chapterProvider.chapterList[0].id ==
                            widget
                                .bookDetailList[
                                    widget.bookDetailList.length - 1]
                                .id
                        ? false
                        : true,
                    enablePullUp: chapterProvider
                                .chapterList[
                                    chapterProvider.chapterList.length - 1]
                                .id ==
                            widget.bookDetailList[0].id
                        ? false
                        : true,
                    controller: _refreshController,
                    scrollController: _scrollController,
                    child: SingleChildScrollView(
                      // controller: _scrollController,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          // itemExtent: 10000,
                          // controller: _scrollController,
                          padding: EdgeInsets.zero,
                          itemCount: chapterProvider.chapterList.length,
                          itemBuilder: (context, index) {
                            return VisibilityDetector(
                              key: Key(index.toString()),
                              onVisibilityChanged: (VisibilityInfo info) {
                                if (_scrollController.hasClients) {
                                  if (_scrollController.position.pixels <=
                                      height * 0.1428) {
                                    chapterProvider.showAppBar();
                                  }
                                  if (_scrollController
                                          .position.userScrollDirection ==
                                      ScrollDirection.reverse) {
                                    if (chapterProvider.isVisible == true)
                                      chapterProvider.dismissAppBar();
                                    if (info.visibleBounds.top == 0 &&
                                        info.visibleBounds.bottom >=
                                            height * 0.5)
                                      chapterProvider.setTitleIndex(index);
                                    // if(info.visibleBounds.bottom > height * 0.5) print(index);
                                  } else if (_scrollController
                                          .position.userScrollDirection ==
                                      ScrollDirection.forward) {
                                    // chapterProvider.dismissAppBar();
                                    if (info.visibleBounds.top == 0 &&
                                        info.visibleBounds.bottom <
                                            height * 0.5)
                                      chapterProvider.setTitleIndex(index - 1);
                                    // if(info.visibleBounds.bottom > height * 0.5) print(index);
                                  }
                                  var chapterNum = chapterProvider
                                      .chapterList[chapterProvider.titleIndex]
                                      .title!
                                      .split(' ')[1];
                                  print(info.visibleBounds.top.toInt());
                                  ReadHistory readHistory = ReadHistory(
                                      readOffset:
                                          info.visibleBounds.top.toInt(),
                                      bookId: widget.readHistory.bookId,
                                      chapterNum: int.parse(chapterNum),
                                      thumbnail: widget.readHistory.thumbnail,
                                      bookName: widget.readHistory.bookName,
                                      detail: widget.readHistory.detail);
                                  context
                                      .read<ReadHistoryProvider>()
                                      .saveReadHistory(readHistory);
                                }

                                // print(info.visibleBounds.top);
                                // if (info.visibleBounds.top > 0) {
                                //   chapterProvider.setTitleIndex(index);
                                // }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    key: chapterProvider.key![index],
                                    height: height * 0.1428,
                                    // child: Center(
                                    //     child: Text(
                                    //         chapterProvider.chapterList[index]
                                    //             .data![0].chapterName!,
                                    //         style: mediumBodyTextStyle)),
                                  ),
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: chapterProvider
                                          .chapterList[index].images!.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        return GestureDetector(
                                            onTap: () => chapterProvider
                                                        .isVisible &&
                                                    _scrollController
                                                            .position.pixels >
                                                        height * 0.1428
                                                ? chapterProvider
                                                    .dismissAppBar()
                                                : chapterProvider.showAppBar(),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              imageUrl: chapterProvider
                                                  .chapterList[index]
                                                  .images![i]
                                                  .image!,
                                              placeholder: (context, url) =>
                                                  Container(
                                                height: 500,
                                                child: Center(
                                                  child:
                                                      CupertinoActivityIndicator(),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                height: 500,
                                                child: Center(
                                                  child:
                                                      CupertinoActivityIndicator(),
                                                ),
                                              ),
                                            )
                                            // child: Image.network(
                                            //   chapterProvider.chapterList[index]
                                            //       .data![i].pageImgUrl!,
                                            //       fit: BoxFit.fill,
                                            // ),
                                            );
                                      }),
                                  Container(
                                      height: 200,
                                      child: Center(
                                          child: Text("comment section")))
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: Consumer<ChapterProvider>(
            builder: (context, chapterProvider, child) => (chapterProvider
                        .isLoading ||
                    chapterProvider.chapterList.isEmpty
                ? Container()
                : AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: chapterProvider.isVisible
                        ? (height > 700 ? 88 : 60)
                        : 0,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.8),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff18274B).withOpacity(.14),
                            offset: Offset(0, 18),
                            spreadRadius: -4,
                            blurRadius: 88),
                        BoxShadow(
                            color: Color(0xff18274B).withOpacity(.12),
                            offset: Offset(0, 8),
                            spreadRadius: -6,
                            blurRadius: 28)
                      ],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16)),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        child: Wrap(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.0426),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // chapterProvider
                                    //               .getChapterData(
                                    //                   widget.bookDetailList[widget.bookDetailList.length - chapterProvider
                                    //                         .titleIndex -1].chapterId!,
                                    //                   0);
                                    // Navigator.of(context).pop();
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChapterDetailScreen(bookDetailList: widget.bookDetailList, chapterIndex: chapterProvider
                                    //                         .titleIndex - 1)));
                                  },
                                  child: Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 0, top: 12),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (chapterProvider
                                                  .chapterList[chapterProvider
                                                      .titleIndex]
                                                  .id ==
                                              widget
                                                  .bookDetailList[widget
                                                          .bookDetailList
                                                          .length -
                                                      1]
                                                  .id) {
                                          } else {
                                            if (chapterProvider.titleIndex !=
                                                0) {
                                              chapterProvider.setTitleIndex(
                                                  chapterProvider.titleIndex -
                                                      1);
                                              Scrollable.ensureVisible(
                                                chapterProvider
                                                    .key![chapterProvider
                                                        .titleIndex]
                                                    .currentContext!,
                                                duration:
                                                    Duration(milliseconds: 500),
                                              );
                                            } else {
                                              chapterProvider
                                                  .removeChapterList();
                                              _refreshIndex++;
                                              _loadIndex++;
                                              chapterProvider.getChapterData(
                                                  widget
                                                      .bookDetailList[
                                                          _refreshIndex]
                                                      .id!,
                                                  0);
                                            }
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              chapterProvider
                                                          .chapterList[
                                                              chapterProvider
                                                                  .titleIndex
                                                                  .compareTo(0)]
                                                          .id ==
                                                      widget
                                                          .bookDetailList[widget
                                                                  .bookDetailList
                                                                  .length -
                                                              1]
                                                          .id
                                                  ? "assets/icons/Last-Chapter-Unavailable.png"
                                                  : "assets/icons/Last-Chapter.png",
                                              height: 24,
                                              width: 24,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Chap trước",
                                              style: mediumTextStyle.copyWith(
                                                  color: chapterProvider
                                                              .chapterList[
                                                                  chapterProvider
                                                                      .titleIndex]
                                                              .id ==
                                                          widget
                                                              .bookDetailList[widget
                                                                      .bookDetailList
                                                                      .length -
                                                                  1]
                                                              .id
                                                      ? Color(0xff5A5A5A)
                                                      : Color(0xffADADAD)),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                Spacer(),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 0, top: 8),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/Comment-Icon.png",
                                          height: 24,
                                          width: 24,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Bình luận",
                                            style: mediumTextStyle.copyWith(
                                                color: Color(0xffADADAD)))
                                      ],
                                    )),
                                Spacer(),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 0, top: 8),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          _index == 2
                                              ? "assets/icons/Like-Selected.png"
                                              : "assets/icons/Like-Unselected.png",
                                          height: 24,
                                          width: 24,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Like",
                                          style: mediumTextStyle.copyWith(
                                              color: _index == 2
                                                  ? Color(0xffDE5A7C)
                                                  : Color(0xffADADAD)),
                                        )
                                      ],
                                    )),
                                Spacer(),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 0, top: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (chapterProvider
                                                .chapterList[
                                                    chapterProvider.titleIndex]
                                                .id ==
                                            widget.bookDetailList[0].id) {
                                        } else {
                                          if (chapterProvider.titleIndex !=
                                              chapterProvider
                                                      .chapterList.length -
                                                  1) {
                                            chapterProvider.setTitleIndex(
                                                chapterProvider.titleIndex + 1);
                                            Scrollable.ensureVisible(
                                              chapterProvider
                                                  .key![chapterProvider
                                                      .titleIndex]
                                                  .currentContext!,
                                              duration:
                                                  Duration(milliseconds: 500),
                                            );
                                          } else {
                                            chapterProvider.removeChapterList();
                                            _refreshIndex--;
                                            _loadIndex--;
                                            chapterProvider.getChapterData(
                                                widget
                                                    .bookDetailList[_loadIndex]
                                                    .id!,
                                                0);
                                          }
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            chapterProvider
                                                        .chapterList[
                                                            chapterProvider
                                                                .titleIndex]
                                                        .id ==
                                                    widget.bookDetailList[0].id
                                                ? "assets/icons/Next-Chapter-Unavailable.png"
                                                : "assets/icons/Next-Chapter.png",
                                            height: 24,
                                            width: 24,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Chap sau",
                                            style: mediumTextStyle.copyWith(
                                                color: chapterProvider
                                                            .chapterList[
                                                                chapterProvider
                                                                    .titleIndex]
                                                            .id ==
                                                        widget.bookDetailList[0]
                                                            .id
                                                    ? Color(0xff5A5A5A)
                                                    : Color(0xffADADAD)),
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ]
                            //     BottomNavigationBar(
                            //       selectedFontSize: 10.0,
                            //       unselectedFontSize: 10.0,
                            //       type: BottomNavigationBarType.fixed,
                            //       showSelectedLabels: true,
                            //       showUnselectedLabels: true,
                            //       backgroundColor: Colors.black.withOpacity(.8),
                            //       items: [
                            //         BottomNavigationBarItem(
                            //           icon:
                            //         ),
                            //         BottomNavigationBarItem(
                            //             label: "Khám phá",
                            //             icon: CustomizedBottomNavBarIcon(
                            //                 source: _index == 1
                            //                     ? "assets/icons/Discover-Selected.png"
                            //                     : "assets/icons/Comment.png",
                            //                 size: 24)),
                            //         BottomNavigationBarItem(
                            //             label: "Thế loại",
                            //             icon: CustomizedBottomNavBarIcon(
                            //                 source: _index == 2
                            //                     ? "assets/icons/Like-Selected.png"
                            //                     : "assets/icons/Like-Unselected.png",
                            //                 size: 24)),
                            //         BottomNavigationBarItem(
                            //             label: "Tủ sách",
                            //             icon: CustomizedBottomNavBarIcon(
                            //                 source: chapterProvider
                            //                             .chapterList[chapterProvider
                            //                                 .titleIndex]
                            //                             .data![0]
                            //                             .chapterId ==
                            //                         widget.bookDetailList[0].chapterId
                            //                     ? "assets/icons/Next-Chapter-Unavailable.png"
                            //                     : "assets/icons/Next-Chapter.png",
                            //                 size: 24)),
                            //       ],
                            //     ),
                            //   ],
                            // )),
                            ))))));
  }
}
