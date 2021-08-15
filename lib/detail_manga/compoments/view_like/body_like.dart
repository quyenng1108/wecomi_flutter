import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/font_const.dart';

class MayBeLike extends StatelessWidget {
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
        Container(
          height: 250 * ratioH,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              MyListView(
                img: 'assets/images/image82.png',
                title_img: 'Mưa đầu hè',
                catogory: 'Tình Yêu . Drama',
              ),
              MyListView(
                img: 'assets/images/image82.png',
                title_img: 'Mưa đầu hè',
                catogory: 'Tình Yêu . Drama',
              ),
              MyListView(
                img: 'assets/images/image82.png',
                title_img: 'Mưa đầu hè',
                catogory: 'Tình Yêu . Drama',
              ),
              MyListView(
                img: 'assets/images/image82.png',
                title_img: 'Mưa đầu hè',
                catogory: 'Tình Yêu . Drama',
              ),
              MyListView(
                img: 'assets/images/image82.png',
                title_img: 'Mưa đầu hè',
                catogory: 'Tình Yêu . Drama',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyListView extends StatelessWidget {
  final String title_img;
  final String catogory;
  final String img;
  MyListView(
      {Key? key,
      required this.title_img,
      required this.img,
      required this.catogory})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      child: InkWell(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0.0,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 0,
                child: Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 2),
                  // decoration: BoxDecoration(color: Colors.black12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(img),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(
                              title_img,
                              textAlign: TextAlign.center,
                              style: kMediumBodyTextStyle,
                            ),
                            Text(
                              catogory,
                              textAlign: TextAlign.center,
                              style: timeComment,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
