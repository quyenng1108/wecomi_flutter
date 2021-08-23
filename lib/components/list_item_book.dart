import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';

class ListItemBook extends StatelessWidget {
  ListItemBook(
      {this.source,
      this.title,
      this.category,
      this.author,
      this.rating,
      this.chapterNum,
      required this.press});
  final VoidCallback press;
  final String? source;
  final String? title;
  final Widget? category;
  final String? author;
  final String? rating;
  final int? chapterNum;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.0147),
      height: height * 0.1675,
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
      child: GestureDetector(
        child: Row(
          children: [
            Container(
              width: width * 0.2906,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(8),
              // ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  source!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.032, vertical: height * 0.0099),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          // margin: EdgeInsets.only(top: height * 0.0098),
                          height: 24,
                          child: Text(
                            title!,
                            style: largeMediumBodyTextStyle,
                            overflow: TextOverflow.ellipsis,
                          )),
                      SizedBox(
                        height: height * 0.0049,
                      ),
                      Container(
                        height: 18,
                        child: category,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset("assets/icons/Author.png", height: 16),
                            SizedBox(width: width * 0.0106),
                            Text(
                              author!,
                              style: smallRegularBodyTextStyle,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0049,
                      ),
                      Container(
                        height: 18,
                        child: Row(
                          children: [
                            Image.asset("assets/icons/Star.png", height: 16),
                            SizedBox(width: width * 0.0106),
                            Text(rating!,
                                style: smallRegularBodyTextStyle.copyWith(
                                    color: majorPink)),
                            Text(" Sao",
                                style: smallRegularLightBlackBodyTextStyle),
                            SizedBox(width: width * 0.0424),
                            Image.asset("assets/icons/Page.png", height: 16),
                            SizedBox(width: width * 0.0106),
                            Text(chapterNum!.toString(),
                                style: smallRegularBodyTextStyle.copyWith(
                                    color: majorPink)),
                            Text(" Chương",
                                style: smallRegularLightBlackBodyTextStyle),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
        onTap: press,
      ),
    );
  }
}
