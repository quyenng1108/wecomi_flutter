import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/list_item_book.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/models/comics.dart';
import 'package:wecomi_flutter/view_models/service_view_models/genre_provider.dart';
import 'package:wecomi_flutter/views/book/book_screen.dart';
import 'package:wecomi_flutter/views/genre/genre_screen.dart';

class SeeAllScreen extends StatefulWidget {
  SeeAllScreen({required this.comicList, required this.category});
  final ComicByCategory comicList;
  final String category;

  @override
  _SeeAllScreenState createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // GenreProvider genreProvider =
      //     Provider.of<GenreProvider>(context, listen: false);
      // genreProvider
      //     .getBooksByCategory(widget.parentCategoryId!, widget.id!)
      //     .then((value) => print(genreProvider.booksByCategory));
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
                        child: BackButton(
                          color: Colors.white
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.0098),
                        child: Container(
                            height: 28,
                            child: Text(
                              widget.category,
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
                child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: widget.comicList.results!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ListItemBook(
                          source:
                              '$apiUrlNoSlash${widget.comicList.results![index].thumbnail}',
                          title: widget.comicList.results![index].title,
                          author: widget.comicList.results![index].author,
                          rating: widget.comicList.results![index].star
                                      .toString() ==
                                  "null"
                              ? "0"
                              : widget.comicList.results![index].star
                                  .toString(),
                          chapterNum: Random().nextInt(10),
                          category: Text(
                              widget.comicList.results![index].tag == null ? "Tổng tài" : "${widget.comicList.results![index].tag}" ,
                              style: smallRegularBodyTextStyle.copyWith(
                                  color: lightBlack)),
                          press: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookScreen(detail: widget.comicList.results![index])))
                          },

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => BookScreen(
                          //           bookID: genreProvider
                          //               .booksByCategory[index]
                          //               .bookUuid
                          //               .toString()),
                          //     )),
                        ),
                      );
                    }),
              ),
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
