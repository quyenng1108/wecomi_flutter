import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/components/category_bubble.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/models/comic.dart';
import 'package:wecomi_flutter/models/comics.dart';
import 'package:wecomi_flutter/view_models/service_view_models/comic_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/genre_provider.dart';
import 'package:wecomi_flutter/views/account/account_screen.dart';
import 'package:wecomi_flutter/views/book/book_screen.dart';
import 'package:wecomi_flutter/views/genre/genre_screen.dart';
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
  ComicByCategory fullComic = ComicByCategory();
  ComicByCategory recommendedComic = ComicByCategory();
  ComicByCategory newComic = ComicByCategory();
  ComicByCategory hotComic = ComicByCategory();

  // @override
  // void afterFirstLayout(BuildContext context) {
  //   // comicProvider = Provider.of<ComicProvider>(context);
  //   comicProvider.getComicBySex(AppSession().sex);
  // }
  @override
  void initState() {
    if (mounted) {}
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      fullComic = await Provider.of<ComicProvider>(context, listen: false)
          .getComicByCategory('full');
      recommendedComic =
          await Provider.of<ComicProvider>(context, listen: false)
              .getComicByCategory('propose');
      newComic = await Provider.of<ComicProvider>(context, listen: false)
          .getComicByCategory('new');
      hotComic = await Provider.of<ComicProvider>(context, listen: false)
          .getComicByCategory('hot');
    });
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
      // comicProvider.showProgress();
      // Future.delayed(Duration(milliseconds: 1000))
      //     .then((value) => comicProvider.getComicBySex(AppSession().sex));
      // setState(() {});
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 8),
              margin: standardSpacing,
              // height: height * 0.0394,
              width: width,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/Logo.png",
                    height: 22,
                    width: 113,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 0),
                        child: SizedBox(
                          height: 44,
                          // width: 278,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(48),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff08252B).withOpacity(.1),
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tìm kiếm",
                                    style: regularLightBlackBodyTextStyle
                                        .copyWith(color: Color(0xff5f5f5f)),
                                  ),
                                  Image.asset("assets/icons/Search.png",
                                      height: 24, width: 24),
                                ],
                              ),
                            ),
                          ),
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
                      : recommendedComic.results == null ||
                              hotComic.results == null ||
                              newComic.results == null ||
                              fullComic.results == null
                          ? Center(
                              child: Text("khong co gi"),
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
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      height: height * 0.0213,
                                    ),
                                    itemBuilder: (context, i) => BannerItems(
                                      source: recommendedComic
                                          .results![i].thumbnail,
                                      press: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BookScreen(
                                                    detail: recommendedComic
                                                        .results![i],
                                                  ))),
                                    ),
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.0345,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28),
                                  child: Container(
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          GenreScreen()));
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    "assets/icons/Genres.png",
                                                    height: 60),
                                                Text("Thể loại")
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Image.asset(
                                                  "assets/icons/Mission.png",
                                                  height: 60),
                                              Text("Nhiệm vụ")
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.asset(
                                                  "assets/icons/Ranking.png",
                                                  height: 60),
                                              Text("Xếp hạng")
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.asset(
                                                  "assets/icons/group.png",
                                                  height: 60),
                                              Text("Nhóm")
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.0345,
                                ),
                                HomeCategoryTitles(
                                  title: "Đề xuất",
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => SeeAllScreen(
                                              comicList: recommendedComic,
                                              category: "Đề xuất"))),
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
                                          source: recommendedComic
                                              .results![i].thumbnail,
                                          title: recommendedComic
                                              .results![i].title,
                                          category: recommendedComic
                                                  .results![i].tag ??
                                              "Tình cảm",
                                          secondCategory: 'Tổng tài',
                                          press: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookScreen(
                                                        detail: recommendedComic
                                                            .results![i],
                                                      ))),
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
                                              comicList: hotComic,
                                              category: "Truyện hot"))),
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
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      height: height * 0.0213,
                                    ),
                                    itemBuilder: (context, i) => HotItems(
                                      source: hotComic.results![i].thumbnail,
                                      press: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BookScreen(
                                              detail: hotComic.results![i],
                                            ),
                                          )),
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
                                              comicList: hotComic,
                                              category: "Có thể bạn thích"))),
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
                                      itemBuilder: (context, index) =>
                                          LikedItems(
                                        height: index == 0
                                            ? height * 0.2365
                                            : height * 0.1749,
                                        width: index == 0
                                            ? width * 0.9146
                                            : width * 0.3786,
                                        source:
                                            hotComic.results![index].thumbnail,
                                        title: hotComic.results![index].title,
                                        category:
                                            hotComic.results![index].tag ??
                                                "Tổng tài",
                                        secondCategory: "Tình cảm",
                                        press: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BookScreen(
                                                detail:
                                                    hotComic.results![index],
                                              ),
                                            )),
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
                                      press: () {},
                                    ),
                                    separatorBuilder: (context, index) =>
                                        Divider(),
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
  BannerItems({@required this.source, required this.press});
  final VoidCallback press;
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
          child: Image.network(
              source != null
                  ? "$apiUrlNoSlash$source"
                  : "https://wallpaperaccess.com/full/8737.jpg",
              height: height * 0.2365,
              width: width * 0.8373,
              fit: BoxFit.fill),
        ),
      ),
      onTap: press,
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
      height: 24,
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
    required this.press,
  });
  final VoidCallback press;
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
                  child: Image.network(
                      source != null
                          ? "$apiUrlNoSlash$source"
                          : "https://wallpaperaccess.com/full/8737.jpg",
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
      onTap: press,
    );
  }
}

class HotItems extends StatelessWidget {
  HotItems({@required this.source, required this.press});
  final VoidCallback press;
  final String? source;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: width * 0.2906,
        height: height * 0.2870,
        margin: EdgeInsets.only(right: width * 0.0213),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
              source != null
                  ? "$apiUrlNoSlash$source"
                  : "https://wallpaperaccess.com/full/8737.jpg",
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
    required this.press,
  });
  final VoidCallback press;
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
                child: Image.network(
                    source != null
                        ? "$apiUrlNoSlash$source"
                        : "https://wallpaperaccess.com/full/8737.jpg",
                    fit: BoxFit.cover),
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
      onTap: press,
    );
  }
}

class NovelItems extends StatelessWidget {
  NovelItems(
      {this.source,
      this.title,
      this.category,
      this.secondCategory,
      required this.press});
  final VoidCallback press;
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
      onTap: press,
    );
  }
}
