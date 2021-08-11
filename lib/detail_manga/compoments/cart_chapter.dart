import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/detail_manga/models/Chapter.dart';

class CardChapter extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback press;

  const CardChapter({
    Key? key,
    required this.chapter,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Stack(
              children: [
                Image.asset(chapter.image),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        chapter.name_chapter + chapter.name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        chapter.date,
                        maxLines: 1,
                        style: textComment,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/heart.png",
                                ),
                                Text(
                                  chapter.heart,
                                  style: textComment,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/comment.png",
                                ),
                                Text(
                                  chapter.comment,
                                  style: textComment,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Opacity(
                    //   opacity: 0.64,
                    //   child: Text(
                    //     chapter.date,
                    //     maxLines: 1,
                    //     style: textComment,
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
