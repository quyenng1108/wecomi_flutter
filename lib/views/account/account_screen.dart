import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/login_related_button.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/view_models/ui_view_models/app_provider.dart';
import 'package:wecomi_flutter/views/login/login_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool? _value;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: CustomBackButton()),
                         Padding(
                           padding: EdgeInsets.only(top: height * 0.0098),
                           child: Center(
                                child: Container(
                                  height: height * 0.0296,
                                  child: Text("Tài khoản", style: smallHeadingTextStyle,textAlign: TextAlign.center,)),
                              ),
                         ),
                  ],
                ),
                SizedBox(
                  height: height * 0.0295,
                ),
                Container(
                  height: 2,
                  color: lighGrey,
                ),
                SizedBox(
                  height: height * 0.0246,
                ),
                NotLoggedInLayout(),
                SizedBox(
                  height: height * 0.0394,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.all(width * 0.0427),
                  height: height * 0.2611,
                  // width: width,
                  margin: standardSpacing,
                  child: Column(
                    children: [
                      RowItem(
                        image: "assets/icons/Upload.png",
                        title: "Đăng tải truyện",
                        widget: Image.asset(
                          "assets/icons/Arrow-Right.png",
                          height: width * 0.064,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0172,
                      ),
                      Container(
                        height: 2,
                        color: Color(0xffF4F6F9),
                      ),
                      SizedBox(
                        height: height * 0.0147,
                      ),
                      RowItem(
                          image: "assets/icons/Language.png",
                          title: "Ngôn ngữ",
                          widget: Image.asset(
                            "assets/icons/Arrow-Right.png",
                            height: width * 0.064,
                          )),
                      SizedBox(
                        height: height * 0.0172,
                      ),
                      Container(
                        height: 2,
                        color: Color(0xffF4F6F9),
                      ),
                      SizedBox(
                        height: height * 0.0147,
                      ),
                      RowItem(
                          image: "assets/icons/Faq.png",
                          title: "Câu hỏi thường gặp",
                          widget: Image.asset(
                            "assets/icons/Arrow-Right.png",
                            height: width * 0.064,
                          )),
                      SizedBox(
                        height: height * 0.0172,
                      ),
                      Container(
                        height: 2,
                        color: Color(0xffF4F6F9),
                      ),
                      SizedBox(
                        height: height * 0.0147,
                      ),
                      RowItem(
                          image: "assets/icons/Dark-Mode.png",
                          title: "Dark Mode",
                          widget: Consumer<AppProvider>(
                            builder: (context, appProvider, child) =>
                                Transform.scale(
                              scale: 0.9,
                              child: CupertinoSwitch(
                                value: _value =
                                    appProvider.theme == ThemeConfig.lightTheme
                                        ? false
                                        : true,
                                onChanged: (v) {
                                  _value == true
                                      ? appProvider.setTheme(
                                          ThemeConfig.lightTheme, 'light')
                                      : appProvider.setTheme(
                                          ThemeConfig.darkTheme, 'dark');
                                  _value = !_value!;
                                },
                                activeColor: Color(0xffDE5A7C),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.022,
                ),
                Container(
                  margin: standardSpacing,
                  height: height * 0.0665,
                  padding: EdgeInsets.all(width * 0.0427),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: RowItem(
                    image: "assets/icons/Logout.png",
                    title: "Đăng xuất",
                    widget: Image.asset(
                      "assets/icons/Arrow-Right.png",
                      height: width * 0.064,
                    ),
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                              content: Text(
                                  "Bạn có chắc chắn muốn đăng xuất không?",
                                  style: largeMediumBodyTextStyle),
                              actions: [
                                CupertinoDialogAction(
                                    onPressed: () => Navigator.pop(context),
                                    isDefaultAction: true,
                                    child:
                                        Text("Hủy", style: defaultActionStyle)),
                                CupertinoDialogAction(
                                    isDefaultAction: false,
                                    child: Text("Đăng xuất",
                                        style: nonDefaultActionStyle)),
                              ],
                            )),
                  ),
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("Vesion 1.27",
                          style: regularExtraLightBlackBodyTextStyle)),
                )
              ],
            ),
          ),
        ));
  }
}

class RowItem extends StatelessWidget {
  RowItem(
      {@required this.image,
      @required this.title,
      required this.widget,
      this.onTap});
  final String? image;
  final String? title;
  final Widget widget;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: width * 0.064,
        child: Row(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  image!,
                  height: width * 0.064,
                )),
            SizedBox(
              width: width * 0.0427,
            ),
            Text(title!, style: largeRegularBodyTextStyle),
            Expanded(
                child: Align(alignment: Alignment.centerRight, child: widget)),
          ],
        ),
      ),
    );
  }
}

class NotLoggedInLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Container(
      height: height * 0.1576,
      padding: standardSpacing,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.asset("assets/images/Avatar-Placeholder.png",
                    height: width * 0.1493),
              ),
              SizedBox(
                width: width * 0.0427,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bạn chưa có tài khoản",
                      style: extraLargeMediumBodyTextStyle),
                  SizedBox(height: height * 0.005),
                  Text("Tạo tài khoản để xem nhiều truyện hay",
                      style: regularLightBlackBodyTextStyle)
                ],
              ),
            ],
          ),
          SizedBox(
            height: height * 0.0295,
          ),
          LoginRelatedButton(
            label: "Đăng nhập",
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen())),
          )
        ],
      ),
    );
  }
}

class LoggedInLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Container(
      height: height * 0.2044,
      padding: standardSpacing,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Image.asset("assets/icons/User-Sample.png",
                height: width * 0.2346),
          ),
          SizedBox(
            height: height * 0.0147,
          ),
          Text("Honghanh242267@gmail.com",
              style: extraLargeDarkGreyMediumBodyTextStyle),
          SizedBox(
            height: height * 0.0147,
          ),
          // SizedBox(
          //   height: height * 0.0295,
          // ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                height: height * 0.0382, width: width * 0.288),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: buttonColor),
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  primary: Theme.of(context).backgroundColor,
                  onPrimary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/icons/Edit.png",
                      height: width * 0.0355,
                    ),
                    Text("Chỉnh sửa", style: mediumPinkBodyTextStyle),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
