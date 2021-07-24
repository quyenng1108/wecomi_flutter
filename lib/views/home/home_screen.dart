import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wecomi_flutter/constants/font_const.dart';

class HomeScreen extends StatefulWidget{

  @override
  _HomeScreenState createState() => _HomeScreenState();

}
int? _selected;
List _category = [
  "Tình yêu",
  "Học đường",
  "Viễn tưởng",
  "Đam Mỹ",
];
List _images = [
  "assets/images/Banner1.jpeg",
  "assets/images/Banner2.jpeg",
  "assets/images/Banner1.jpeg",
  "assets/images/Banner2.jpeg"
];
List _hot = [
  "assets/images/Hot1.jpeg",
  "assets/images/Hot2.jpeg",
  "assets/images/Hot1.jpeg",
  "assets/images/Hot2.jpeg",
  "assets/images/Hot1.jpeg",
  "assets/images/Hot2.jpeg",
  "assets/images/Hot1.jpeg",
  "assets/images/Hot2.jpeg",
];

class _HomeScreenState extends State<HomeScreen> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.0427),
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
                            duration: Duration(
                                milliseconds: 700
                            ),
                          // decoration: BoxDecoration(
                          //   color: Colors.green,
                          //   borderRadius: BorderRadius.circular(14),
                          //   border: Border.all(
                          //     color: Colors.black,
                          //     width: 1
                          //   )
                          // ),
                          child:
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: width * 0.064,
                                  width: width * 0.117,
                                decoration: BoxDecoration(
                                color: Color(0xffE4E8EF),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Color(0xffD6DDE8),
                                  width: 1
                                )
                            ),
                                ),
                              ),
                              AnimatedPositioned(
                                curve:Curves.easeIn,
                                // top: 3.0,
                                left: _value ? 20 : 0,
                                right: _value ? 0 : 20,
                                duration: Duration(
                                  milliseconds: 700
                              ),

                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _value = !_value;
                                    });
                                  },
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 700),
                                    transitionBuilder: (Widget child, Animation<double> animation){
                                      return RotationTransition(
                                        turns: animation,
                                        child: child,
                                      );
                                    },
                                    child: _value ? ClipRRect(
                                      key: UniqueKey(),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(14.0),
                                          topRight: Radius.circular(14.0),
                                        ),
                                        child: Image.asset(
                                            'assets/icons/Group_male.png',
                                            width: width * 0.064,
                                            height: width * 0.064,
                                            fit:BoxFit.fill
                                        ))
                                        : ClipRRect(
                                        key: UniqueKey(),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                        ),
                                        child: Image.asset(
                                            'assets/icons/Group_female.png',
                                            width: width * 0.064,
                                            height: width * 0.064,
                                            fit:BoxFit.fill
                                        ))

                                  ),
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
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                          child: Image.asset("assets/icons/Search.png", height: width * 0.064, width: width * 0.064),
                          onTap: (){
                            // Do something
                          },
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.asset("assets/icons/User_sample.png",height: width * 0.085, width: width * 0.085),
                        )
                          ],),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.0197,
              ),
              Container(
                height: height * 0.2365,
                child: ListView.separated(
                  padding: EdgeInsets.only(left:width * 0.0426, right: width * 0.0213),
                  itemCount: _images.length,
                  separatorBuilder: (context, index)
                  => Divider(
                    height: height * 0.0213,
                  ),
                  itemBuilder: (context, i)
                  => BannerItems(source: _images[i],),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: height * 0.0345,
              ),
              HomeCategoryTitles(
                title: "Đề xuất",
              ),
              SizedBox(
                height: height * 0.0074,
              ),
              Container(
                height: height * 0.3485,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.032),
                  crossAxisCount: 2,
                  childAspectRatio: 168 / 135,
                  children: [
                    for(int i = 0; i < 4; i++) RecommendedItems(
                      source: _images[i],
                      title: "Nụ hôn đẫm máu",
                      category: "Tình cảm",
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
              ),
               SizedBox(
                height: height * 0.0148,
              ),
              Container(
                height: height * 0.2870,
                child: ListView.separated(
                  padding: EdgeInsets.only(left:width * 0.0426, right: width * 0.0213),
                  itemCount: _images.length,
                  separatorBuilder: (context, index)
                  => Divider(
                    height: height * 0.0213,
                  ),
                  itemBuilder: (context, i)
                  => HotItems(source: _hot[i],),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: height * 0.027,
              ),
              HomeCategoryTitles(title: "Có thể bạn thích",),
              SizedBox(
                height: height * 0.0148,
              ),
              Container(
                height: height * 0.0345,
                child: ListView.separated(
                  padding: EdgeInsets.only(left:width * 0.0426, right: width * 0.0213),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) 
                  => GestureDetector(
                    onTap: (){
                      setState(() {
                      _selected = index;                        
                      });
                    },
                    child: Container(
                      padding:EdgeInsets.only(right: width * 0.0213),
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: _selected != null && _selected == index ? Color(0xffF05A77) : Colors.white,
                          boxShadow: [
                            BoxShadow(
                            color: Color(0xff08252B).withOpacity(.1),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: Offset(0,1), // changes position of shadow
                          ),
                        ],
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Container(
                          // alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: width * 0.0266),
                          child: Center(
                            child: Text(_category[index],textAlign: TextAlign.center, style :_selected != null && _selected == index ? smallRegularWhiteBodyTextStyle : smallRegularGreyBodyTextStyle
                            ),
                          ))
                        ),
                    ),
                  ), 
                  separatorBuilder: (context, index) 
                  => Divider(
                    height: height * 0.0213,
                  ), 
                  itemCount: _category.length),
              ),
              SizedBox(
                height: height * 0.0148,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.0427),
                child: Container(
                  height: height * 0.537,
                  child:
                   StaggeredGridView.countBuilder(
                     physics: NeverScrollableScrollPhysics(),
                     mainAxisSpacing: width * 0.0426,
                     crossAxisSpacing: width * 0.0213,
                     itemCount: 4,
                    // shrinkWrap: true,
                    crossAxisCount: 3, 
                    itemBuilder: (context, index) =>
                    LikedItems(
                      height: index == 0 ? height * 0.2365: height * 0.1749,
                      width: index == 0 ? width * 0.9146: width* 0.3786,
                      source: _images[index],
                      title: "Cô thư ký xinh đẹp",
                      category: "Tổng tài",
                      secondCategory: "Tình cảm",
                    ),
                    staggeredTileBuilder: (index) => StaggeredTile.extent(
                        (index == 0) ? 3 : 1,(index == 0) ? height * 0.2894 : height * 0.2278 ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.059,
              ),
            ],
          ),
        ),
      )
    );
  }
}
class BannerItems extends StatelessWidget{
  BannerItems({
    @required this.source
  });
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
                child: Image.asset(source!, height: height * 0.2365, width:width * 0.8373, fit: BoxFit.fill),
              ),
            ),

      onTap: (){

      },
    );
}
}
class HomeCategoryTitles extends StatelessWidget{
  HomeCategoryTitles({
    @required this.title,
    this.onTap
  });
  final String? title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.0427),
                height: height * 0.0283,
                width: width,
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(title!, style: smallHeadingTextStyle),
                      )
                      ),
                      Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: Text("Xem tất cả", style: smallRegularGreyBodyTextStyle),
                          onTap: this.onTap,
                          ),
                      )
                      ),
                  ],
                ),
              );
  }
}
class RecommendedItems extends StatelessWidget{
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
                        padding: EdgeInsets.symmetric(horizontal: width * 0.0107, vertical: height * 0.0074),
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
                child: Image.asset(source!, height: height * 0.1182, width:width * 0.448, fit: BoxFit.fill),
                  ),
                ),
                          ),
                SizedBox(
                  height: height * 0.0049,
                ),

                    Container(
                      alignment: Alignment.centerLeft,
                      height: height * 0.0259,
                      child: Text(title!, style: mediumBodyTextStyle,overflow: TextOverflow.ellipsis),
                    ),


                Container(
                    alignment: Alignment.centerLeft,
                  height: height * 0.0172,
                  child: Text("$category • $secondCategory", style: regularTextStyle,overflow: TextOverflow.ellipsis),
                ),

                          ],
                        ),
                      ),
                  onTap: (){

                  },
                    );
  }
}
class HotItems extends StatelessWidget{
  HotItems({
    @required this.source
  });
  final String? source;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: Container(
        width: width * 0.2907,
        height: height * 0.2870,
        margin: EdgeInsets.only(right: width * 0.0213),
        child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(source!, height: height * 0.2870, width:width * 0.2907, fit: BoxFit.fill),
              ),
      ),
    );
  }
}
class LikedItems extends StatelessWidget{
  LikedItems({
    @required this.source,
    @required this.category,
    @required this.secondCategory,
    @required this.title,
    @required this.height,
    @required this.width
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
                        child: Image.asset(source!, fit: BoxFit.cover),
                  ),
              ),
            ),
            SizedBox(
                  height: height * 0.0049,
                ),

                    Container(
                      alignment: Alignment.centerLeft,
                      height: height * 0.0259,
                      child: Text(title!, style: mediumBodyTextStyle,overflow: TextOverflow.ellipsis),
                    ),


                Container(
                    alignment: Alignment.centerLeft,
                  height: height * 0.0172,
                  child: Text("$category • $secondCategory", style: regularTextStyle,overflow: TextOverflow.ellipsis),
                ),
          ],
      ),
      onTap: (){

      },
    );
  }

}