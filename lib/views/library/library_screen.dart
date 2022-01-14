import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/list_item_book.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font.dart';
import 'package:wecomi_flutter/constants/utils.dart';
import 'package:wecomi_flutter/models/comics.dart';
import 'package:wecomi_flutter/view_models/service_view_models/follow_book_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/read_history_provider.dart';
import 'package:wecomi_flutter/views/book/book_screen.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  FollowBookProvider followBookProvider = FollowBookProvider();
  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      _tabController = TabController(length: 3, vsync: this);
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        context.read<ReadHistoryProvider>().loadHistory();
        // followBookProvider =
        //     Provider.of<FollowBookProvider>(context, listen: false);
        // if (AppSession().token != null) {
        //   followBookProvider.getFollowedBookList(AppSession().token!);
        // }
        context.read<FollowBookProvider>().loadFollowedBook();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLogged = Provider.of<LoginProvider>(context).isLogged;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                  height: height * 0.1922,
                  width: width,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                          colors: [Color(0xffB85985), Color(0xffF05A80)],
                          center: Alignment(-.95, -1.35),
                          radius: 3.5))),
              Container(
                  height: 35,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top +
                          (height * 0.0197),
                      left: 0,
                      right: 0),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            height: 36,
                            width: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              color: Colors.white.withOpacity(.25)
                            ),
                            child: Image.asset("assets/icons/edit_white.png", height: 24,)
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.0098),
                          child: Container(
                              height: 29,
                              child: Text(
                                "Tủ sách",
                                style: giganticMediumBodyTextStyle.copyWith(
                                    color: Colors.white),
                                // textAlign: TextAlign.center,
                              )),
                        ),
                      ),
                    ],
                  )),
              Container(
                height: height * 0.8534,
                margin: EdgeInsets.only(top: height * 0.1466),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned.fill(
                            child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffE9E8F0),
                                width: 2,
                              ),
                            ),
                          ),
                        )),
                        TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(text: "Theo dõi"),
                            Tab(text: "Lịch sử"),
                            Tab(text: "Tải xuống")
                          ],
                          labelColor: Color(0xffF05A77),
                          labelStyle: mediumBodyTextStyle,
                          unselectedLabelStyle: regularBodyTextStyle,
                          unselectedLabelColor: Color(0xff7F7F7F),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Color(0xffF05A77),
                          indicatorWeight: 2,
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                      controller: _tabController,
                      children: [
                        Center(
                          child: FollowedBookScreen(),
                        ),
                        Center(
                          child: ReadHistoryScreen(),
                        ),
                        Center(
                          child: Text("Chức năng đang được phát triển"),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

class ReadHistoryScreen extends StatelessWidget {
  const ReadHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReadHistoryProvider>(
        builder: (context, readHistoryProvider, child) {
      return readHistoryProvider.readHistoryList.isEmpty
          ? Text("Bạn chưa đọc truyện nào")
          : ListView.builder(
              padding: EdgeInsets.only(top: 4),
              itemCount: readHistoryProvider.readHistoryList.length,
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff08252B).withOpacity(.1),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ]),
                      height: 136,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          // Utils.deleteDb();
                          ComicDetail detail = ComicDetail.fromJson(json.decode(
                              readHistoryProvider.readHistoryList.reversed
                                  .toList()[index]
                                  .detail!));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookScreen(detail: detail)));
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 108,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  readHistoryProvider.readHistoryList.reversed
                                              .toList()[index]
                                              .thumbnail !=
                                          null
                                      ? "$apiUrlNoSlash${readHistoryProvider.readHistoryList.reversed.toList()[index].thumbnail}"
                                      : "https://i.pinimg.com/564x/be/7e/f7/be7ef776a74fc0076717be1166f42d76.jpg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.topLeft,
                                          // margin: EdgeInsets.only(top: height * 0.0098),
                                          height: 24,
                                          child: Text(
                                            readHistoryProvider
                                                .readHistoryList.reversed
                                                .toList()[index]
                                                .bookName!,
                                            style: largeMediumBodyTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      Container(
                                          alignment: Alignment.topLeft,
                                          // margin: EdgeInsets.only(top: height * 0.0098),
                                          height: 24,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Chương mới nhất: ",
                                                style: smallRegularBodyTextStyle
                                                    .copyWith(
                                                        color:
                                                            Color(0xff999999)),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "Chương 4",
                                                style: smallRegularBodyTextStyle
                                                    .copyWith(
                                                        color: buttonColor),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    // margin: EdgeInsets.only(top: height * 0.0098),
                                    height: 24,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Đang đọc: ",
                                          style: smallRegularBodyTextStyle
                                              .copyWith(
                                                  color: Color(0xff999999)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Chương ${readHistoryProvider.readHistoryList.reversed.toList()[index].chapterNum}",
                                          style: smallRegularBodyTextStyle
                                              .copyWith(color: buttonColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ));
    });
  }
}

class FollowedBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FollowBookProvider>(
        builder: (context, followedBookProvider, child) {
      return followedBookProvider.followedBookList.isEmpty
          ? Center(child: Text("Bạn chưa theo dõi truyện nào"))
          : ListView.builder(
              padding: EdgeInsets.only(top: 4),
              itemCount: followedBookProvider.followedBookList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: ListItemBook(
                      source: followedBookProvider.followedBookList.reversed
                                  .toList()[index]
                                  .thumbnail !=
                              null
                          ? "$apiUrlNoSlash${followedBookProvider.followedBookList.reversed.toList()[index].thumbnail}"
                          : "https://i.pinimg.com/564x/be/7e/f7/be7ef776a74fc0076717be1166f42d76.jpg",
                      title: followedBookProvider.followedBookList.reversed
                          .toList()[index]
                          .bookName,
                      author: followedBookProvider.followedBookList.reversed
                          .toList()[index]
                          .author,
                      rating: followedBookProvider.followedBookList.reversed
                          .toList()[index]
                          .star
                          .toString(),
                      chapterNum: followedBookProvider.followedBookList.reversed
                          .toList()[index]
                          .numOfChapters,
                      category: Text("Comic",
                          style: smallRegularBodyTextStyle.copyWith(
                              color: lightBlack)),
                      press: () {
                        ComicDetail detail = ComicDetail.fromJson(json.decode(
                            followedBookProvider.followedBookList.reversed
                                .toList()[index]
                                .detail!));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookScreen(
                                    detail: detail,
                                  )),
                        );
                      }),
                );
              });
    });
  }
}
