import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/detail_manga/repositories/comic_provider.dart';

import '../../detail_screen_manga.dart';

class ReCommend extends StatefulWidget {
  ReCommend({Key? key}) : super(key: key);
  @override
  _ReCommendState createState() => _ReCommendState();
}

class _ReCommendState extends State<ReCommend> {
  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Truyện tương tự",
                style: kLargeMediumBodyTextStyle1,
              )
            ],
          ),
        ),
        Consumer<ComicProvider>(builder: (context, comicProvider, child) {
          // final detailComic = comicProvider.comic
          //     .where((element) => element.bookId == widget.bookID);

          return comicProvider.comic.length == 0 && !comicProvider.isLoading
              ? LinearProgressIndicator()
              : comicProvider.isLoading
                  ? Shimmer.fromColors(
                      child: Container(
                        height: 71 * ratioH,
                        width: 343 * ratioW,
                      ),
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!)
                  : Container(
                      padding: EdgeInsets.only(top: 12 * ratioH),
                      height: 200 * ratioH,
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: comicProvider.reCommend!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return _recommed(
                              press: () =>
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DetailScreenManga(
                                        bookID: comicProvider
                                            .reCommend![index].bookUuid
                                            .toString(),
                                      );
                                    },
                                  )),
                              img: comicProvider.reCommend![index].imgUrl
                                  .toString(),
                              bookName: comicProvider.reCommend![index].bookname
                                  .toString(),
                              catogoryName: comicProvider
                                  .reCommend![index].categoryName
                                  .toString());
                        },
                      ),
                    );
        })
      ],
    );
  }

  Widget _recommed(
      {VoidCallback? press,
      String? bookName,
      String? catogoryName,
      String? img,
      String? subCategory}) {
    subCategory = 'Abc';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: press,
        child: Container(
          width: 104,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  img!,
                  height: 136,
                  fit: BoxFit.cover,
                  width: 104,
                ),
              ),
              Text(
                bookName!,
                textAlign: TextAlign.center,
                style: kSmallMediumBodyTextStyle,
                maxLines: 1,
              ),
              Text(
                '$catogoryName • $subCategory',
                textAlign: TextAlign.center,
                style: timeComment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
