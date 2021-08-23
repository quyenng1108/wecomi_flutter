import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/list_item_book.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/view_models/service_view_models/genre_provider.dart';
import 'package:wecomi_flutter/views/book/book_screen.dart';
import 'package:wecomi_flutter/views/genre/genre_screen.dart';

class SeeAllScreen extends StatefulWidget {
  SeeAllScreen(
      {@required this.screenName,
      @required this.id,
      @required this.parentCategoryId});
  final String? screenName;
  final int? id;
  final int? parentCategoryId;

  @override
  _SeeAllScreenState createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      GenreProvider genreProvider =
          Provider.of<GenreProvider>(context, listen: false);
      genreProvider
          .getBooksByCategory(widget.parentCategoryId!, widget.id!)
          .then((value) => print(genreProvider.booksByCategory));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Scaffold(
      body: Column(
        children: [
          Stack(
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
                width: width,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: CustomBackButton(
                          color: Colors.white,
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.0098),
                        child: Container(
                            height: 28,
                            child: Text(
                              widget.screenName!,
                              style: giganticMediumBodyTextStyle.copyWith(
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                      ),
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
                    builder: (context, genreProvider, child) =>
                        ListView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: height * 0.0049,
                                horizontal: width * 0.0426),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              var category;
                              var secondCategory;
                              var categoryList;
                              if (genreProvider.isLoading == false) {
                                categoryList = genreProvider
                                    .booksByCategory[index].categoryList!
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
                                      period: Duration(milliseconds: 700),
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
                                          .booksByCategory[index].imgUrl,
                                      title: genreProvider
                                          .booksByCategory[index].bookName,
                                      author: genreProvider
                                          .booksByCategory[index].authorNick,
                                      rating: genreProvider
                                          .booksByCategory[index].rating,
                                      chapterNum: genreProvider
                                          .booksByCategory[index]
                                          .numberOfChapter,
                                      category: categoryList.length > 1
                                          ? Text(
                                              "$category • $secondCategory",
                                              style: smallRegularBodyTextStyle
                                                  .copyWith(color: lightBlack),
                                            )
                                          : Text(
                                              "${genreProvider.booksByCategory[index].categoryList}",
                                              style: smallRegularBodyTextStyle
                                                  .copyWith(color: lightBlack)),
                                      press: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BookScreen(
                                                bookID: genreProvider
                                                    .booksByCategory[index]
                                                    .bookUuid
                                                    .toString()),
                                          )),
                                    );
                            }),
                  )),
            ],
            // ),
          ),
          // ),
          // ],
          // ),
        ],
      ),
    );
  }
}
