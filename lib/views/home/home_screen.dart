import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/components/category_bubble.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/models/comic.dart';
import 'package:wecomi_flutter/view_models/service_view_models/comic_provider.dart';
import 'package:wecomi_flutter/views/account/account_screen.dart';
import 'package:wecomi_flutter/views/search/search_screen.dart';
import 'package:wecomi_flutter/views/see_all_screen/see_all_screen.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  HomeScreen({required this.scrollController});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List _novel = [
  "assets/images/Novel-1.png",
  "assets/images/Novel-2.png",
  "assets/images/Novel-3.png",
];

class _HomeScreenState extends State<HomeScreen>
// with AfterLayoutMixin<HomeScreen>
{
  ComicProvider comicProvider = ComicProvider();
  // @override
  // void afterFirstLayout(BuildContext context) {
  //   // comicProvider = Provider.of<ComicProvider>(context);
  //   comicProvider.getComicBySex(AppSession().sex);
  // }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    super.dispose();
    comicProvider.dispose();
  }

  @override
  Widget build(BuildContext context) {
    comicProvider = Provider.of<ComicProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    Future<void> _refreshData() async {
      comicProvider.showProgress();
      Future.delayed(Duration(milliseconds: 1000))
          .then((value) => comicProvider.getComicBySex(AppSession().sex));
      // setState(() {});
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: standardSpacing,
              height: height * 0.0394,
              width: width,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        height: width * 0.064,
                        width: width * 0.117,
                        duration: Duration(milliseconds: 700),
                        // decoration: BoxDecoration(
                        //   color: Colors.green,
                        //   borderRadius: BorderRadius.circular(14),
                        //   border: Border.all(
                        //     color: Colors.black,
                        //     width: 1
                        //   )
                        // ),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: width * 0.064,
                                width: width * 0.117,
                                decoration: BoxDecoration(
                                    color: Color(0xffE4E8EF),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                        color: Color(0xffD6DDE8), width: 1)),
                              ),
                            ),
                            AnimatedPositioned(
                              curve: Curves.easeIn,
                              // top: 3.0,
                              left: AppSession().sex == 1 ? 20 : 0,
                              right: AppSession().sex == 1 ? 0 : 20,
                              duration: Duration(milliseconds: 700),

                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    AppSession().sex == 1
                                        ? AppSession().changeSexGroup(2)
                                        : AppSession().changeSexGroup(1);
                                  });
                                  comicProvider.isLoading = true;
                                  Future.delayed(Duration(milliseconds: 1000))
                                      .then((value) => comicProvider
                                          .getComicBySex(AppSession().sex));
                                },
                                child: AnimatedSwitcher(
                                    // switchInCurve: Curves.easeOut,
                                    // switchOutCurve: Curves.easeOut,
                                    duration: Duration(milliseconds: 700),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return RotationTransition(
                                        turns: animation,
                                        child: child,
                                      );
                                    },
                                    child: AppSession().sex == 1
                                        ? ClipRRect(
                                            key: Key("1"),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(14.0),
                                              topRight: Radius.circular(14.0),
                                            ),
                                            child: Image.asset(
                                                'assets/icons/Group-Male.png',
                                                width: width * 0.064,
                                                height: width * 0.064,
                                                fit: BoxFit.fill))
                                        : ClipRRect(
                                            key: Key("2"),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                            ),
                                            child: Image.asset(
                                                'assets/icons/Group-Female.png',
                                                width: width * 0.064,
                                                height: width * 0.064,
                                                fit: BoxFit.fill))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/icons/Logo.png",
                        height: height * 0.022,
                        width: width * 0.24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: width * 0.192,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Image.asset("assets/icons/Search.png",
                                  height: width * 0.064, width: width * 0.064),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SearchScreen()));
                              },
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AccountScreen())),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: Image.asset(
                                    "assets/icons/User-Sample.png",
                                    height: width * 0.085,
                                    width: width * 0.085),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.0197,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshData(),
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  physics: comicProvider.isLoading
                      ? NeverScrollableScrollPhysics()
                      : AlwaysScrollableScrollPhysics(),
                  child: comicProvider.isLoading
                      ? Column(
                          children: [
                            Container(
                              height: height * 0.2365,
                              child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                    left: width * 0.0426,
                                    right: width * 0.0213),
                                itemCount: 4,
                                separatorBuilder: (context, index) => Divider(
                                  height: height * 0.0213,
                                ),
                                itemBuilder: (context, i) => Shimmer.fromColors(
                                  loop: 1,
                                  // enabled: false,
                                  period: Duration(milliseconds: 700),
                                  baseColor: Color(0xffE4E8EF),
                                  highlightColor: Color(0xffC9D1E0),
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: width * 0.0213),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xffE4E8EF),
                                    ),
                                    width: width * 0.8373,
                                    height: height * 0.2365,
                                  ),
                                ),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.0345,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Shimmer.fromColors(
                                loop: 1,
                                baseColor: Color(0xffE4E8EF),
                                highlightColor: Color(0xffC9D1E0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xffE4E8EF),
                                  ),
                                  margin: standardSpacing,
                                  height: height * 0.0283,
                                  width: width * 0.2133,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.0074,
                            ),
                            Container(
                              height: height * 0.3486,
                              child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.032),
                                crossAxisCount: 2,
                                childAspectRatio:
                                    (width * 0.448) / (height * 0.1663),
                                children: [
                                  for (int i = 0; i < 4; i++)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.0107,
                                          vertical: height * 0.0074),
                                      height: height * 0.1743,
                                      width: width * 0.448,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Shimmer.fromColors(
                                              loop: 1,
                                              period:
                                                  Duration(milliseconds: 700),
                                              baseColor: Color(0xffE4E8EF),
                                              highlightColor: Color(0xffC9D1E0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color(0xffE4E8EF),
                                                ),
                                                width: width * 0.448,
                                                height: height * 0.1182,
                                                margin: EdgeInsets.only(
                                                    right: width * 0.0213),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.0049,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Shimmer.fromColors(
                                              loop: 1,
                                              period:
                                                  Duration(milliseconds: 700),
                                              baseColor: Color(0xffE4E8EF),
                                              highlightColor: Color(0xffC9D1E0),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    right: width * 0.1333),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color(0xffE4E8EF),
                                                ),
                                                width: width * 0.3146,
                                                height: height * 0.0197,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.0049,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Shimmer.fromColors(
                                              loop: 1,
                                              period:
                                                  Duration(milliseconds: 700),
                                              baseColor: Color(0xffE4E8EF),
                                              highlightColor: Color(0xffC9D1E0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color(0xffE4E8EF),
                                                ),
                                                width: width * 0.2133,
                                                height: height * 0.0172,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.027,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Shimmer.fromColors(
                                loop: 1,
                                baseColor: Color(0xffE4E8EF),
                                highlightColor: Color(0xffC9D1E0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xffE4E8EF),
                                  ),
                                  margin: standardSpacing,
                                  height: height * 0.0283,
                                  width: width * 0.2133,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              height: height * 0.2365,
                              child: ListView.separated(
                                physics: comicProvider.isLoading
                                    ? NeverScrollableScrollPhysics()
                                    : AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                    left: width * 0.0426,
                                    right: width * 0.0213),
                                itemCount: 4,
                                separatorBuilder: (context, index) => Divider(
                                  height: height * 0.0213,
                                ),
                                itemBuilder: (context, i) => BannerItems(
                                  source:
                                      comicProvider.recommendedComic?[i].imgUrl,
                                ),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.0345,
                            ),
                            HomeCategoryTitles(
                              title: "Đề xuất",
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => SeeAllScreen(
                                          screenName: "Đề xuất",
                                          parentCategoryId: 1,
                                          id: 9998))),
                            ),
                            SizedBox(
                              height: height * 0.0074,
                            ),
                            Container(
                              height: height * 0.3485,
                              child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.032),
                                crossAxisCount: 2,
                                childAspectRatio:
                                    (width * 0.448) / (height * 0.1663),
                                children: [
                                  for (int i = 0; i < 4; i++)
                                    RecommendedItems(
                                      source: comicProvider
                                          .recommendedComic?[i].imgUrl,
                                      title: comicProvider
                                          .recommendedComic?[i].bookname,
                                      category: comicProvider
                                          .recommendedComic?[i].categoryName,
                                      secondCategory: 'Tổng tài',
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.027,
                            ),
                            HomeCategoryTitles(
                              title: "Truyện hot",
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => SeeAllScreen(
                                          screenName: "Truyện hot",
                                          parentCategoryId: 1,
                                          id: 9998))),
                            ),
                            SizedBox(
                              height: height * 0.0148,
                            ),
                            Container(
                              height: height * 0.2870,
                              child: ListView.separated(
                                padding: EdgeInsets.only(
                                    left: width * 0.0426,
                                    right: width * 0.0213),
                                itemCount: 4,
                                separatorBuilder: (context, index) => Divider(
                                  height: height * 0.0213,
                                ),
                                itemBuilder: (context, i) => HotItems(
                                  source: comicProvider.hotComic?[i].imgUrl,
                                ),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.027,
                            ),
                            HomeCategoryTitles(
                              title: "Có thể bạn thích",
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => SeeAllScreen(
                                          screenName: "Có thể bạn thích",
                                          parentCategoryId: 1,
                                          id: 9999))),
                            ),
                            // SizedBox(
                            //   height: height * 0.0148,
                            // ),
                            // Container(
                            //   height: height * 0.0345,
                            //   child: ListView.separated(
                            //       padding: EdgeInsets.only(
                            //           left: width * 0.0426, right: width * 0.0213),
                            //       scrollDirection: Axis.horizontal,
                            //       itemBuilder: (context, index) => CategoryBubble(
                            //             onTap: () {
                            //               setState(() {
                            //                 _selected = index;
                            //               });
                            //             },
                            //             color: _selected != null && _selected == index
                            //                 ? Color(0xffF05A77)
                            //                 : Colors.white,
                            //             style: _selected != null && _selected == index
                            //                 ? smallRegularWhiteBodyTextStyle
                            //                 : smallRegularGreyBodyTextStyle,
                            //             category: _category[index],
                            //           ),
                            //       separatorBuilder: (context, index) => Divider(
                            //             height: height * 0.0213,
                            //           ),
                            //       itemCount: _category.length),
                            // ),
                            SizedBox(
                              height: height * 0.0148,
                            ),
                            Padding(
                              padding: standardSpacing,
                              child: Container(
                                height: height * 0.537,
                                child: StaggeredGridView.countBuilder(
                                  physics: NeverScrollableScrollPhysics(),
                                  mainAxisSpacing: width * 0.0426,
                                  crossAxisSpacing: width * 0.0213,
                                  itemCount: 4,
                                  // shrinkWrap: true,
                                  crossAxisCount: 3,
                                  itemBuilder: (context, index) => LikedItems(
                                    height: index == 0
                                        ? height * 0.2365
                                        : height * 0.1749,
                                    width: index == 0
                                        ? width * 0.9146
                                        : width * 0.3786,
                                    source:
                                        comicProvider.likedComic?[index].imgUrl,
                                    title: comicProvider
                                        .likedComic?[index].bookname,
                                    category: comicProvider
                                        .likedComic?[index].categoryName,
                                    secondCategory: "Tình cảm",
                                  ),
                                  staggeredTileBuilder: (index) =>
                                      StaggeredTile.extent(
                                          (index == 0) ? 3 : 1,
                                          (index == 0)
                                              ? height * 0.2894
                                              : height * 0.2278),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.027,
                            ),
                            Container(
                                margin: standardSpacing,
                                height: height * 0.0283,
                                width: width,
                                child: Text("Tiểu thuyết hot",
                                    style: smallHeadingTextStyle)),
                            SizedBox(
                              height: height * 0.0148,
                            ),
                            Container(
                              height: height * 0.1662,
                              child: ListView.separated(
                                itemBuilder: (context, index) => NovelItems(
                                  category: "Tổng tài",
                                  secondCategory: "Lãng mạn",
                                  source: _novel[index],
                                  title: "Ngày mai sẽ đến",
                                ),
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: _novel.length,
                                padding: EdgeInsets.only(
                                    left: width * 0.0426,
                                    right: width * 0.0213),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.059,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerItems extends StatelessWidget {
  BannerItems({@required this.source});
  final String? source;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: Container(
        width: width * 0.8373,
        height: height * 0.2365,
        margin: EdgeInsets.only(right: width * 0.0213),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(source!,
              height: height * 0.2365, width: width * 0.8373, fit: BoxFit.fill),
        ),
      ),
      onTap: () {},
    );
  }
}

class HomeCategoryTitles extends StatelessWidget {
  HomeCategoryTitles({@required this.title, this.onTap});
  final String? title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Container(
      margin: standardSpacing,
      height: height * 0.0283,
      width: width,
      child: Row(
        children: [
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title!, style: smallHeadingTextStyle),
          )),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text("Xem tất cả", style: smallRegularGreyBodyTextStyle),
              onTap: this.onTap,
            ),
          )),
        ],
      ),
    );
  }
}

class RecommendedItems extends StatelessWidget {
  RecommendedItems({
    @required this.source,
    @required this.title,
    @required this.category,
    @required this.secondCategory,
  });
  final String? source;
  final String? title;
  final String? category;
  final String? secondCategory;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.0107, vertical: height * 0.0074),
        height: height * 0.1743,
        width: width * 0.448,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                width: width * 0.448,
                height: height * 0.1182,
                // margin: EdgeInsets.only(right: width * 0.0213),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(source!,
                      height: height * 0.1182,
                      width: width * 0.448,
                      fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.0049,
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: height * 0.0259,
              child: Text(title!,
                  style: mediumBodyTextStyle, overflow: TextOverflow.ellipsis),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: height * 0.0172,
              child: Text("$category • $secondCategory",
                  style: regularGreyTextStyle, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}

class HotItems extends StatelessWidget {
  HotItems({@required this.source});
  final String? source;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width * 0.2906,
        height: height * 0.2870,
        margin: EdgeInsets.only(right: width * 0.0213),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(source!,
              height: height * 0.2870,
              width: width * 0.2907,
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class LikedItems extends StatelessWidget {
  LikedItems({
    @required this.source,
    @required this.category,
    @required this.secondCategory,
    @required this.title,
    @required this.height,
    @required this.width,
  });
  final String? title;
  final String? category;
  final String? secondCategory;
  final String? source;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: Column(
        children: [
          Flexible(
            child: Container(
              width: width,
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(source!, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.0049,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: height * 0.0259,
            child: Text(title!,
                style: mediumBodyTextStyle, overflow: TextOverflow.ellipsis),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: height * 0.0172,
            child: Text("$category • $secondCategory",
                style: regularGreyTextStyle, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}

class NovelItems extends StatelessWidget {
  NovelItems({this.source, this.title, this.category, this.secondCategory});
  final String? source;
  final String? title;
  final String? category;
  final String? secondCategory;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.0107, vertical: height * 0.0074),
        height: height * 0.1743,
        width: width * 0.368,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                width: width * 0.448,
                height: height * 0.1182,
                // margin: EdgeInsets.only(right: width * 0.0213),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(source!,
                      height: height * 0.1083,
                      width: width * 0.448,
                      fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.0049,
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: height * 0.0259,
              child: Text(title!,
                  style: mediumBodyTextStyle, overflow: TextOverflow.ellipsis),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: height * 0.0172,
              child: Text("$category • $secondCategory",
                  style: regularGreyTextStyle, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
