import 'dart:convert';
import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:wecomi_flutter/components/bottom_nav_bar_icon.dart';
import 'package:wecomi_flutter/components/linked_offset_widget.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/models/comics.dart';
import 'package:wecomi_flutter/models/followed_book.dart';
import 'package:wecomi_flutter/models/read_history.dart';
import 'package:wecomi_flutter/view_models/service_view_models/book_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/follow_book_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/getchapter_byBookuuid_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/read_history_provider.dart';
import 'package:wecomi_flutter/views/book/view_tab/tab_chapter/tab_chapter.dart';
import 'package:wecomi_flutter/views/book/view_tab/tab_details/body_comments.dart';
import 'package:wecomi_flutter/views/book/view_tab/tab_details/bottom_recommend.dart';
import 'package:wecomi_flutter/views/book/view_tab/tab_details/header_detials_book.dart';
import 'package:wecomi_flutter/views/chapter_detail/chapter_detail_screen.dart';

class BookScreen extends StatefulWidget {
  final ComicDetail? detail;
  BookScreen({Key? key, @required this.detail})
      : super(
          key: key,
        );

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ChapterByBookIDProvider>(context, listen: false)
          .getChapterByBookId(widget.detail!.id!);
      // Provider.of<BookProvider>(context, listen: false).fetBook(widget.bookID);
    });
  }

  // double get _horizontalTitlePadding {
  //   const kBasePadding = 32.0;
  //   const kMultiplier = 0.5;
  //   final ratioH = MediaQuery.of(context).size.height / 896;
  //   final kExpandedHeight = ratioH * 320 - 80;

  //   if (_scrollController.hasClients) {
  //     if (_scrollController.offset < (kExpandedHeight / 2)) {
  //       // In case 50%-100% of the expanded height is viewed
  //       return kBasePadding;
  //     }

  //     if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
  //       // In case 0% of the expanded height is viewed
  //       return (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
  //           kBasePadding;
  //     }

  //     // In case 0%-50% of the expanded height is viewed
  //     return (_scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
  //         kBasePadding;
  //   }

  //   return kBasePadding;
  // }

  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      title: LinkedOffsetWidget(
                        originTransitionOffsetY: 40,
                        finalTransitionOffsetY: 0,
                        child:
                            // Consumer<BookProvider>(
                            //   builder: (context, bookProvider, child) {
                            //     return
                            //         // bookProvider.book.length == 0 &&
                            //         !bookProvider.isLoading
                            //     ? LinearProgressIndicator()
                            //     : bookProvider.isLoading
                            //         ? Shimmer.fromColors(
                            //             child: Container(
                            //                 width: 229 * ratioW,
                            //                 height: 35 * ratioH),
                            //             baseColor: Colors.grey[300]!,
                            //             highlightColor: Colors.grey[100]!)
                            //         :
                            Text(
                          "${widget.detail!.title}",
                          style: TextStyle(color: Colors.white),
                          //   );
                          // },
                        ),
                        scrollController: _scrollController,
                        onOffsetChanged: (double offset) {},
                      ),
                      stretch: true,
                      centerTitle: true,
                      leading: BackButton(
                          // onPressed: () {
                          //   Navigator.of(context).pop();
                          // },
                          ),
                      actions: [
                        IconButton(
                          color: Colors.green,
                          icon: CustomizedBottomNavBarIcon(
                              source: "assets/icons/Received.png", size: 35),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.only(bottom: 48.0),
                        child: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Container(
                            child:
                                // Consumer<BookProvider>(
                                //   builder: (context, bookProvider, child) {
                                //     return
                                // bookProvider.book.length == 0 &&
                                //         !bookProvider.isLoading
                                //     ? LinearProgressIndicator()
                                //     : bookProvider.isLoading
                                //         ? Shimmer.fromColors(
                                //             child: Container(
                                //               height: 251 * ratioH,
                                //             ),
                                //             baseColor: Colors.grey[300]!,
                                //             highlightColor: Colors.grey[100]!)
                                //         :
                                Container(
                              child: Image.network(
                                  widget.detail?.thumbnail != null
                                      ? "$apiUrlNoSlash${widget.detail?.thumbnail}"
                                      : "https://wallpaperaccess.com/full/8737.jpg",
                                  fit: BoxFit.cover),
                              //   );
                              // },
                            ),
                          ),
                          stretchModes: <StretchMode>[
                            StretchMode.zoomBackground,
                          ],
                          title: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0 * ratioH,
                                horizontal: 16.0 * ratioW),
                            child: LinkedOffsetWidget(
                              scrollController: _scrollController,
                              originTransitionOffsetY: 0,
                              finalTransitionOffsetY: -100,
                              onOffsetChanged: (double offset) {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Consumer<BookProvider>(
                                  //   builder: (context, bookProvider, child) {
                                  //     return
                                  // bookProvider.book.length == 0 &&
                                  //         !bookProvider.isLoading
                                  //     ? LinearProgressIndicator()
                                  //     : bookProvider.isLoading
                                  //         ? Shimmer.fromColors(
                                  //             child: Container(),
                                  //             baseColor: Colors.grey[300]!,
                                  //             highlightColor: Colors.grey[100]!)
                                  //         :
                                  Text(
                                    '${widget.detail!.title}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                    //   );
                                    // },
                                  ),
                                  // Consumer<BookProvider>(
                                  //   builder: (context, bookProvider, child) =>
                                  // bookProvider.isLoading
                                  //     ? Row()
                                  //     :
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Consumer<BookProvider>(
                                      //   builder:
                                      //       (context, bookProvider, child) {
                                      (widget.detail!.status != 'full')
                                          ? Text(
                                              'Đang cập nhật',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8),
                                            )
                                          : Text(
                                              'Đã hoàn thành',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8),
                                            ),

                                      //   },
                                      // ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: 5 * ratioW),
                                              child: Image.asset(
                                                "assets/icons/lich.png",
                                                width: 13 * ratioW,
                                                height: 13 * ratioH,
                                              ),
                                            ),
                                            Text(
                                              "Thứ 3 & 6",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          titlePadding: EdgeInsets.zero,
                        ),
                      ),
                      backgroundColor: ThemeConfig.bgColor,
                      elevation: 3.0,
                      pinned: true,
                      snap: false,
                      primary: true,
                      forceElevated: innerBoxIsScrolled,
                      automaticallyImplyLeading: true,
                      expandedHeight: ratioH * 251,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(40),
                        child: Container(
                          color: Colors.white,
                          height: 51 * ratioH,
                          child: TabBar(
                            tabs: [
                              Tab(
                                text: 'Thông tin truyện',
                              ),
                              Tab(
                                text: 'Danh sách chương',
                              ),
                            ],
                            labelColor: Color(0xffF05A77),
                            unselectedLabelColor: Color(0xff7F7F7F),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: Color(0xffF05A77),
                            indicatorWeight: 3,
                            indicatorPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            controller: _tabController,
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [_tab1(), _tab2()],
              ),
            ),
          ),
          // Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: 120,
          //     decoration: BoxDecoration(
          //         gradient: LinearGradient(colors: [
          //       Color(0xffDFDFDF).withOpacity(.4),
          //       Colors.transparent
          //     ], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
        ],
      ),
      bottomNavigationBar: BottomNavTabDetails(
        detail: widget.detail,
      ),
    );
  }

  Widget _tab1() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Content(comicDetail: widget.detail),
              Comments(),
              ReCommend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab2() {
    return Container(
        child: TabChapter(
      detail: widget.detail!,
      bookID: widget.detail!.id!,
    ));
  }
}

class BottomNavTabDetails extends StatefulWidget {
  const BottomNavTabDetails({
    @required this.detail,
    Key? key,
  }) : super(key: key);
  final ComicDetail? detail;
  @override
  _BottomNavTabDetails createState() => _BottomNavTabDetails();
}

class _BottomNavTabDetails extends State<BottomNavTabDetails> {
  int chapNum = 1;
  bool hasExistedInReadHistory = false;
  int followedBookIndex = 0;
  int offset = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chapterList =
        context.select((ChapterByBookIDProvider p) => p.chapterByBookId);
    bool isLoading = context.select((ChapterByBookIDProvider p) => p.isLoading);

    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        height: 71 * ratioH,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    // padding: EdgeInsets.only(left: 26 * ratioW, top: 6),
                    child: TextButton(
                      onPressed: showSheet,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icons/share.png",
                            height: 20 * ratioH,
                            width: 20 * ratioW,
                          ),
                          Container(
                            child: Text(
                              "Chia sẻ",
                              style: textColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Builder(builder: (context) {
                      var followedBookList =
                          context.watch<FollowBookProvider>().followedBookList;
                      bool hasFollowed = false;
                      for (int i = 0; i < followedBookList.length; i++) {
                        if (widget.detail!.id == followedBookList[i].bookId) {
                          followedBookIndex = i;
                          hasFollowed = true;
                          break;
                        }
                      }
                      return hasFollowed
                          ? TextButton(
                              onPressed: () {
                                context
                                    .read<FollowBookProvider>()
                                    .unfollowBook(followedBookIndex);
                                // var bookDetail = json.encode(widget.detail!.toJson());
                                // FollowedBook followedBook = FollowedBook(
                                //     bookId: widget.detail!.id,
                                //     thumbnail: widget.detail!.thumbnail,
                                //     author: widget.detail!.author,
                                //     numOfChapters: Random().nextInt(10),
                                //     bookName: widget.detail!.title,
                                //     detail: bookDetail);
                                // context
                                //     .read<FollowBookProvider>()
                                //     .followBook(followedBook);
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/icons/heart_fill.png",
                                    height: 20 * ratioH,
                                    width: 20 * ratioW,
                                  ),
                                  Container(
                                    child: Text(
                                      "Theo dõi",
                                      style: textColor,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                var bookDetail =
                                    json.encode(widget.detail!.toJson());
                                FollowedBook followedBook = FollowedBook(
                                    bookId: widget.detail!.id,
                                    thumbnail: widget.detail!.thumbnail,
                                    author: widget.detail!.author,
                                    numOfChapters: Random().nextInt(10),
                                    bookName: widget.detail!.title,
                                    detail: bookDetail);
                                context
                                    .read<FollowBookProvider>()
                                    .followBook(followedBook);
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/icons/heart-add.png",
                                    height: 20 * ratioH,
                                    width: 20 * ratioW,
                                  ),
                                  Container(
                                    child: Text(
                                      "Theo dõi",
                                      style: textColor,
                                    ),
                                  )
                                ],
                              ),
                            );
                    }),
                  ),
                ],
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  var bookDetail = json.encode(widget.detail!.toJson());
                  var history = ReadHistory(
                      readOffset: offset,
                      chapterNum: chapNum,
                      bookId: widget.detail!.id,
                      thumbnail: widget.detail!.thumbnail,
                      bookName: widget.detail!.title,
                      detail: bookDetail);
                  context.read<ReadHistoryProvider>().saveReadHistory(history);
                  if (!isLoading)
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChapterDetailScreen(
                            offset: offset.toDouble(),
                            readHistory: history,
                            bookDetailList: chapterList.chapter!,
                            chapterIndex: chapterList.chapter!.length -
                                (chapNum - 1) -
                                1)));
                },
                child: Container(
                  height: 42 * ratioH,
                  width: 167 * ratioW,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ThemeConfig.bgColor),
                    color: ThemeConfig.bgColor,
                  ),
                  // child: Container(
                  // padding:
                  // EdgeInsets.fromLTRB(0, 13.0 * ratioH, 0, 13.0 * ratioH),
                  child: Builder(builder: (context) {
                    var readHistoryList =
                        context.watch<ReadHistoryProvider>().readHistoryList;
                    for (int i = 0; i < readHistoryList.length; i++) {
                      if (widget.detail!.id == readHistoryList[i].bookId) {
                        offset = readHistoryList[i].readOffset;
                        chapNum = readHistoryList[i].chapterNum;
                        hasExistedInReadHistory = true;
                        break;
                      }
                    }
                    return Center(
                        child: isLoading
                            ? SizedBox(
                                height: 12,
                                width: 12,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : !hasExistedInReadHistory
                                ? Text(
                                    'Đọc ngay',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Tiếp tục Ch.$chapNum',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ));
                  }),
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }

  Future showSheet() => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          cornerRadius: 20,
          snapSpec: SnapSpec(
            snappings: [0.4, 0.7],
          ),
          builder: buildSheet,
        ),
      );
  Widget buildSheet(context, state) => Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 29, horizontal: 89),
              child: Text(
                "Chia sẻ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            _buildSheetBottom(
              title: 'Sao chép đường liên kết',
              icon: 'assets/icons/link.png',
            ),
            _buildSheetBottom(
              title: 'Chia sẻ qua Facebook ',
              icon: 'assets/icons/Facebook.png',
            ),
            _buildSheetBottom(
              title: 'Chia sẻ qua Tin nhắn',
              icon: 'assets/icons/Mess.png',
            ),
            _buildSheetBottom(
              title: 'Chia sẻ qua Twitter',
              icon: 'assets/icons/Twitter.png',
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ThemeConfig.bgColor),
                  color: ThemeConfig.bgColor,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Chia sẻ lên Wecomi Forum",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ThemeConfig.bgColor),
                  color: ThemeConfig.bgColor,
                ),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Hủy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  Widget _buildSheetBottom({String? title, String? icon}) {
    return Column(
      children: [
        const Divider(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title!,
                textAlign: TextAlign.center,
              ),
              Image.asset(icon!),
            ],
          ),
        ),
      ],
    );
  }
}
