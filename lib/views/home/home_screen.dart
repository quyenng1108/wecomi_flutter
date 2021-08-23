import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/detail_manga/detail_screen_manga.dart';
import 'package:wecomi_flutter/detail_manga/repositories/comic_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ComicProvider comicProvider = ComicProvider();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ComicProvider>(context, listen: false).getComic();
    });
  }

  bool positive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Center(
          child: Consumer<ComicProvider>(
            builder: (context, value, child) {
              return value.comic.length == 0 && !value.isLoading
                  ? CircularProgressIndicator()
                  : value.isLoading
                      ? Shimmer.fromColors(
                          child: Container(),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!)
                      : InkWell(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.comic.length,
                              itemBuilder: (context, index) {
                                return MyListView(
                                  bookName: value.comic[index].bookname,
                                  img: value.comic[index].imgUrl,
                                  catogory: value.comic[index].bookUuid,
                                  press: () =>
                                      Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DetailScreenManga(
                                        bookID: value.comic[index].bookUuid
                                            .toString(),
                                      );
                                    },
                                  )),
                                );
                              },
                            ),
                          ),
                        );
            },
          ),
        ),
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  final VoidCallback press;
  final String? bookName;
  final String? catogory;
  final String? img;
  MyListView(
      {Key? key,
      required this.bookName,
      required this.img,
      required this.catogory,
      required this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      child: InkWell(
        onTap: press,
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
                        child: Image.network(
                          img!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              height: 24,
                              child: Text(
                                bookName!,
                                textAlign: TextAlign.center,
                                style: kMediumBodyTextStyle,
                              ),
                            ),
                            Text(
                              catogory!,
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
