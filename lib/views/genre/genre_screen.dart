import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/list_item_book.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/models/book_by_category.dart';
import 'package:wecomi_flutter/models/comic.dart';
import 'package:wecomi_flutter/view_models/service_view_models/comic_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/genre_provider.dart';
import 'package:wecomi_flutter/views/book/book_screen.dart';
import 'package:wecomi_flutter/views/search/search_screen.dart';

class GenreScreen extends StatefulWidget {
  final ScrollController? scrollController;
  GenreScreen({@required this.scrollController});
  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _index = 0;
  AutoScrollController _scrollController = AutoScrollController();
  // GenreProvider genreProvider = GenreProvider();
  Future scrollToIndex(int index) async {
    await _scrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.middle);
  }

  @override
  void initState() {
    super.initState();

    if (this.mounted) {
      _tabController = TabController(length: 2, vsync: this);
      //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

      // });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
    _scrollController.dispose();
    // genreProvider.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    top: MediaQuery.of(context).padding.top + (height * 0.0197),
                    left: width * 0.0426,
                    right: width * 0.0426),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: width * 0.5786,
                        decoration: BoxDecoration(
                          
                            color: Color(0xffDA7395),
                            borderRadius: BorderRadius.circular(8)),
                        child: Consumer<GenreProvider>(
                            builder: (context, genreProvider, child) => TabBar(
                                  onTap: (index) {
                                    setState(() {
                                      _index = 0;
                                    });
                                    genreProvider.showProgress();
                                    Future.delayed(Duration(milliseconds: 500))
                                        .then((value) => genreProvider
                                            .getCategory(index + 1))
                                        .then((value) =>
                                            genreProvider.getBooksByCategory(
                                                _index + 1, 9998));
                                    print(_index);
                                  },
                                  controller: _tabController,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ),
                                    color: Colors.white,
                                  ),
                                  labelColor: Color(0xff5E3A78),
                                  labelStyle: mediumBodyTextStyle,
                                  unselectedLabelColor: Colors.white,
                                  unselectedLabelStyle: mediumBodyTextStyle,
                                  labelPadding: EdgeInsets.zero,
                                  tabs: [
                                    Tab(
                                      text: 'Truyện tranh',
                                    ),
                                    // second tab [you can add an icon using the icon property]
                                    Tab(
                                      text: 'Tiểu thuyết',
                                    ),
                                  ],
                                ))),
                    GestureDetector(
                      child: Image.asset(
                        "assets/icons/Search.png",
                        height: 24,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                  height: height * 0.8534,
                  margin: EdgeInsets.only(top: height * 0.1466),
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Consumer<GenreProvider>(
                    builder: (context, genreProvider, child) => TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        Consumer<GenreProvider>(
                          builder: (context, genreProvider, child) => Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: height * 0.0197),
                                height: 35,
                                child:
                                    // child: genreProvider.isLoading
                                    //     ? ListView.separated(
                                    //         scrollDirection: Axis.horizontal,
                                    //         itemCount: 5,
                                    //         separatorBuilder: (context, index) =>
                                    //             Divider(),
                                    //         padding: EdgeInsets.symmetric(
                                    //             horizontal: width * 0.0426),
                                    //         physics: NeverScrollableScrollPhysics(),
                                    //         itemBuilder: (context, index) =>
                                    //             Shimmer.fromColors(
                                    //                 loop: 1,
                                    //                 // enabled: false,
                                    //                 period:
                                    //                     Duration(milliseconds: 700),
                                    //                 baseColor: Color(0xffE4E8EF),
                                    //                 highlightColor:
                                    //                     Color(0xffC9D1E0),
                                    //                 child: Container(
                                    //                   width: 80,
                                    //                   padding: EdgeInsets.symmetric(
                                    //                       horizontal: 16),
                                    //                   margin:
                                    //                       EdgeInsets.only(left: 12),
                                    //                   decoration: BoxDecoration(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(
                                    //                             16),
                                    //                     color: Color(0xffE4E8EF),
                                    //                   ),
                                    //                 )),
                                    //       )
                                    //     :
                                    ListView.builder(
                                        controller: _scrollController,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.0426),
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            genreProvider.subCategory.length,
                                        itemBuilder: (context, index) =>
                                            AutoScrollTag(
                                              index: index,
                                              key: ValueKey(index),
                                              controller: _scrollController,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _index = index;
                                                  });
                                                  scrollToIndex(index);
                                                  genreProvider.showProgress();
                                                  Future.delayed(Duration(
                                                          milliseconds: 700))
                                                      .then((value) => genreProvider
                                                          .getBooksByCategory(
                                                              _index + 1,
                                                              genreProvider
                                                                  .subCategory[
                                                                      index]
                                                                  .categoryId!));
                                                },
                                                child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 21),
                                                    // margin: EdgeInsets.only(left: 12),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              width: 2,
                                                              color: _index ==
                                                                      index
                                                                  ? Color(
                                                                      0xffF05A77)
                                                                  : Color(
                                                                      0xffE9E8F0))),
                                                      // color: Colors.green
                                                    ),
                                                    child: Text(
                                                      genreProvider
                                                          .subCategory[index]
                                                          .categoryName!,
                                                      style: regularBodyTextStyle
                                                          .copyWith(
                                                              color: _index ==
                                                                      index
                                                                  ? majorPink
                                                                  : Color(
                                                                      0xff7F7F7F)),
                                                    )),
                                              ),
                                            )),
                              ),
                              Expanded(
                                child: ListView.separated(
                                    controller: widget.scrollController,
                                    physics: genreProvider.isLoading
                                        ? NeverScrollableScrollPhysics()
                                        : AlwaysScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(
                                        top: height * 0.0197,
                                        bottom: height * 0.0394,
                                        left: width * 0.0427,
                                        right: width * 0.0427),
                                    itemBuilder: (context, index) {
                                      var category;
                                      var secondCategory;
                                      var categoryList;
                                      if (Provider.of<GenreProvider>(context)
                                              .isLoading ==
                                          false) {
                                        categoryList = genreProvider
                                            .booksByCategory[index]
                                            .categoryList!
                                            .split(";");
                                        if (categoryList.length > 1) {
                                          category = categoryList[0];
                                          secondCategory = categoryList[1];
                                        }
                                      }
                                      return genreProvider.isLoading
                                          ? Shimmer.fromColors(
                                              loop: 1,
                                              // enabled: false,
                                              period:
                                                  Duration(milliseconds: 700),
                                              baseColor: Color(0xffE4E8EF),
                                              highlightColor: Color(0xffC9D1E0),
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: height * 0.0147),
                                                height: height * 0.1675,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color(0xffE4E8EF),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>BookScreen(bookID: genreProvider
                                                    .booksByCategory[index].bookUuid!))),
                                            child: ListItemBook(
                                                source: genreProvider
                                                    .booksByCategory[index]
                                                    .imgUrl,
                                                title: genreProvider
                                                    .booksByCategory[index]
                                                    .bookName,
                                                author: genreProvider
                                                    .booksByCategory[index]
                                                    .authorNick,
                                                rating: genreProvider
                                                    .booksByCategory[index]
                                                    .rating,
                                                chapterNum: genreProvider
                                                    .booksByCategory[index]
                                                    .numberOfChapter,
                                                category: categoryList.length > 1
                                                    ? Text(
                                                        "$category • $secondCategory",
                                                        style:
                                                            smallRegularBodyTextStyle
                                                                .copyWith(
                                                                    color:
                                                                        lightBlack),
                                                      )
                                                    : Text(
                                                        "${genreProvider.booksByCategory[index].categoryList}",
                                                        style: smallRegularBodyTextStyle
                                                            .copyWith(
                                                                color:
                                                                    lightBlack)),
                                              ),
                                          );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          height: 0,
                                        ),
                                    itemCount: genreProvider.isLoading
                                        ? 4
                                        : genreProvider.booksByCategory.length),
                              )
                            ],
                          ),
                        ),
                        Consumer<GenreProvider>(
                          builder: (context, genreProvider, child) => Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: height * 0.0197),
                                height: 35,
                                child:
                                    // genreProvider.isLoading
                                    //     ? ListView.separated(
                                    //         scrollDirection: Axis.horizontal,
                                    //         itemCount: 5,
                                    //         separatorBuilder: (context, index) =>
                                    //             Divider(),
                                    //         padding: EdgeInsets.symmetric(
                                    //             horizontal: width * 0.0426),
                                    //         physics: NeverScrollableScrollPhysics(),
                                    //         itemBuilder: (context, index) =>
                                    //             Shimmer.fromColors(
                                    //                 loop: 1,
                                    //                 // enabled: false,
                                    //                 period:
                                    //                     Duration(milliseconds: 700),
                                    //                 baseColor: Color(0xffE4E8EF),
                                    //                 highlightColor:
                                    //                     Color(0xffC9D1E0),
                                    //                 child: Container(
                                    //                   width: 80,
                                    //                   padding: EdgeInsets.symmetric(
                                    //                       horizontal: 16),
                                    //                   margin:
                                    //                       EdgeInsets.only(left: 12),
                                    //                   decoration: BoxDecoration(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(
                                    //                             16),
                                    //                     color: Color(0xffE4E8EF),
                                    //                   ),
                                    //                 )),
                                    //       )
                                    // :
                                    ListView.builder(
                                        controller: _scrollController,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.0426),
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            genreProvider.subCategory.length,
                                        itemBuilder: (context, index) =>
                                            AutoScrollTag(
                                              index: index,
                                              key: ValueKey(index),
                                              controller: _scrollController,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _index = index;
                                                    scrollToIndex(_index);
                                                    genreProvider.showProgress();
                                                  Future.delayed(Duration(
                                                          milliseconds: 700))
                                                      .then((value) => genreProvider
                                                          .getBooksByCategory(
                                                              _index + 1,
                                                              genreProvider
                                                                  .subCategory[
                                                                      index]
                                                                  .categoryId!));
                                                  });
                                                },
                                                child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 21),
                                                    // margin: EdgeInsets.only(left: 12),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              width: 2,
                                                              color: _index ==
                                                                      index
                                                                  ? Color(
                                                                      0xffF05A77)
                                                                  : Color(
                                                                      0xffE9E8F0))),
                                                      // color: Colors.green
                                                    ),
                                                    child: Text(
                                                      genreProvider
                                                          .subCategory[index]
                                                          .categoryName!,
                                                      style: regularBodyTextStyle
                                                          .copyWith(
                                                              color: _index ==
                                                                      index
                                                                  ? majorPink
                                                                  : Color(
                                                                      0xff7F7F7F)),
                                                    )),
                                              ),
                                            )),
                              ),
                              Expanded(
                                child: ListView.separated(
                                    controller: widget.scrollController,
                                    padding: EdgeInsets.only(
                                        top: height * 0.0197,
                                        bottom: height * 0.0394,
                                        left: width * 0.0427,
                                        right: width * 0.0427),
                                    itemBuilder: (context, index) {
                                      var category;
                                      var secondCategory;
                                      var categoryList = genreProvider
                                          .booksByCategory[index].categoryList!
                                          .split(";");
                                      if (categoryList.length > 1) {
                                        category = categoryList[0];
                                        secondCategory = categoryList[1];
                                      }
                                      return genreProvider.isLoading
                                          ? Shimmer.fromColors(
                                              loop: 1,
                                              // enabled: false,
                                              period:
                                                  Duration(milliseconds: 700),
                                              baseColor: Color(0xffE4E8EF),
                                              highlightColor: Color(0xffC9D1E0),
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: height * 0.0147),
                                                height: height * 0.1675,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color(0xffE4E8EF),
                                                ),
                                              ),
                                            )
                                          : ListItemBook(
                                              source: genreProvider
                                                  .booksByCategory[index]
                                                  .imgUrl,
                                              title: genreProvider
                                                  .booksByCategory[index]
                                                  .bookName,
                                              author: genreProvider
                                                  .booksByCategory[index]
                                                  .authorNick,
                                              rating: genreProvider
                                                  .booksByCategory[index]
                                                  .rating,
                                              chapterNum: genreProvider
                                                  .booksByCategory[index]
                                                  .numberOfChapter,
                                              category: categoryList.length > 1
                                                  ? Text(
                                                      "$category • $secondCategory",
                                                      style:
                                                          smallRegularBodyTextStyle
                                                              .copyWith(
                                                                  color:
                                                                      lightBlack),
                                                    )
                                                  : Text(
                                                      "${genreProvider.booksByCategory[index].categoryList}",
                                                      style: smallRegularBodyTextStyle
                                                          .copyWith(
                                                              color:
                                                                  lightBlack)),
                                            );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          height: 0,
                                        ),
                                    itemCount:
                                        genreProvider.booksByCategory.length),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        )
      ],
    ));
  }
}
