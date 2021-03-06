import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/login_related_button.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/view_models/service_view_models/change_information_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/follow_book_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/local_auth_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';
import 'package:wecomi_flutter/view_models/ui_view_models/app_provider.dart';
import 'package:wecomi_flutter/views/login/login_screen.dart';
import 'package:after_layout/after_layout.dart';
import 'package:wecomi_flutter/views/user_profile/user_profile_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with AfterLayoutMixin<AccountScreen> {
  bool? _value;
  // bool isUsingLocalAuth = false;
  LoginProvider loginProvider = LoginProvider();
  @override
  void afterFirstLayout(BuildContext context) {
    loginProvider.checkLoginState();
  }

  @override
  void didChangeDependencies() {
    print("did");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isUsingLocalAuth =
        context.select((LocalAuthProvider p) => p.isUsingLocalAuth);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    loginProvider = Provider.of<LoginProvider>(context);
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("T??i kho???n", style: giganticMediumBodyTextStyle),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
            child: Container(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              // Stack(
              //   children: [
              //     Align(
              //         alignment: Alignment.centerLeft,
              //         child: CustomBackButton(
              //           color: darkGrey,
              //         )),
              //     Padding(
              //       padding: EdgeInsets.only(top: height * 0.0098),
              //       child: Center(
              //         child: Container(
              //             height: 28,
              //             child: Text(
              //               "T??i kho???n",
              //               style: giganticMediumBodyTextStyle,
              //               textAlign: TextAlign.center,
              //             )),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: height * 0.0295,
              // ),
              Container(
                height: 2,
                color: lightGrey,
              ),
              SizedBox(
                height: height * 0.0246,
              ),
              loginProvider.isLogged == true
                  ? LoggedInLayout()
                  : NotLoggedInLayout(),
              SizedBox(
                height: height * 0.0394,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(width * 0.0427),
                // height: height * 0.2611,
                // width: width,
                margin: standardSpacing,
                child: Column(
                  children: [
                    RowItem(
                      image: "assets/icons/Upload.png",
                      title: "????ng t???i truy???n",
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
                        title: "Ng??n ng???",
                        widget: Image.asset(
                          "assets/icons/Arrow-Right.png",
                          height: width * 0.064,
                        )),
                    // SizedBox(
                    //   height: height * 0.0172,
                    // ),
                    // Container(
                    //   height: 2,
                    //   color: Color(0xffF4F6F9),
                    // ),
                    // SizedBox(
                    //   height: height * 0.0147,
                    // ),
                    // RowItem(
                    //     image: "assets/icons/Faq.png",
                    //     title: "C??u h???i th?????ng g???p",
                    //     widget: Image.asset(
                    //       "assets/icons/Arrow-Right.png",
                    //       height: width * 0.064,
                    //     )),
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
                    loginProvider.isLogged
                        ? RowItem(
                            image: "assets/icons/faceid.png",
                            title: "X??c th???c khu??n m???t",
                            widget: Consumer<AppProvider>(
                              builder: (context, appProvider, child) =>
                                  Transform.scale(
                                scale: 0.9,
                                child: CupertinoSwitch(
                                  value: isUsingLocalAuth,
                                  onChanged: (v) {
                                    context
                                        .read<LocalAuthProvider>()
                                        .authenticate();
                                  },
                                  activeColor: Color(0xffDE5A7C),
                                ),
                              ),
                            ))
                        : SizedBox()
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.022,
              ),
              loginProvider.isLogged
                  ? Container(
                      margin: standardSpacing,
                      height: height * 0.0665,
                      padding: EdgeInsets.all(width * 0.0427),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: RowItem(
                        image: "assets/icons/Logout.png",
                        title: "????ng xu???t",
                        widget: Image.asset(
                          "assets/icons/Arrow-Right.png",
                          height: width * 0.064,
                        ),
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  content: Text(
                                      "Ba??n co?? ch????c ch????n mu????n ????ng xu????t kh??ng?",
                                      style: largeMediumBodyTextStyle),
                                  actions: [
                                    CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        isDefaultAction: true,
                                        child: Text("H???y",
                                            style: defaultActionStyle)),
                                    CupertinoDialogAction(
                                        isDefaultAction: false,
                                        child: Text("????ng xu???t",
                                            style: nonDefaultActionStyle),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          loginProvider.logout();
                                          // context
                                          //     .read<LocalAuthProvider>()
                                          //     .onLogout();
                                          // Provider.of<FollowBookProvider>(
                                          //         context)
                                          //     .followedBook = null;
                                        }),
                                  ],
                                )),
                      ),
                    )
                  : Container(),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text("Vesion 1.27",
                          style: regularExtraLightBlackBodyTextStyle),
                    )),
              )
            ],
          ),
        )));
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
    return
        // Container(
        //   height: height * 0.1576,
        //   padding: standardSpacing,
        //   child:
        Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: standardSpacing,
          child: Row(
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
                  Text("B???n ch??a ????ng nh???p",
                      style: extraLargeMediumBodyTextStyle),
                  SizedBox(height: height * 0.005),
                  Text("????ng nh???p ?????? xem nhi????u truy????n hay",
                      style: regularLightBlackBodyTextStyle)
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.0295,
        ),
        LoginRelatedButton(
          label: "????ng nh???p",
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())),
        )
      ],
      // ),
    );
  }
}

class LoggedInLayout extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    bool isEditing =
        context.select((ChangeInformationProvider p) => p.isEditing);
        bool isLoading =
        context.select((ChangeInformationProvider p) => p.isLoading);
        String avatar = context.select((LoginProvider p) => p.avatar!);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Container(
      // height: height * 0.2044,
      padding: standardSpacing,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  int id = AppSession().userId!;
                  if (!isEditing) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserProfileScreen(
                              userId: id,
                            )));
                  } else {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (contextt) => CupertinoActionSheet(
                              actions: [
                                CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.of(context).pop();

                                      pickImageFromGallery(context);
                                    },
                                    child: Text("Ch???n t??? b??? s??u t???p")),
                                CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.of(context).pop();

                                      pickImageFromCamera(context);
                                    },
                                    child: Text("Ch???p ???nh")),
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("H???y",
                                      style: TextStyle(color: buttonColor))),
                            ));
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Image.network(context.watch<LoginProvider>().avatar!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover),
                ),


              ),
              isEditing
                  ? Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                          padding: EdgeInsets.all(4),
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: lightGrey),
                          child:
                              Image.asset("assets/icons/Edit.png", height: 18)))
                  : SizedBox(),
              isLoading ?
                Positioned(
                  right: 33,
                  bottom: 33,
                  child: CircularProgressIndicator(color: lightGrey,))
              :SizedBox()
            ],

          ),
          SizedBox(
            height: height * 0.0147,
          ),
          Text(context.watch<LoginProvider>().accountName!,
              style: extraLargeDarkGreyMediumBodyTextStyle),
          SizedBox(
            height: height * 0.0147,
          ),
          ElevatedButton(
              onPressed: () {
                context.read<ChangeInformationProvider>().toggleEditing();
              },
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  primary: buttonColor,
                  onPrimary: Color(0xffB85985),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48))),
              child: Text( isEditing ? "Xong" : "Ch???nh s???a", style: smallRegularWhiteBodyTextStyle)),
          SizedBox(
            height: height * 0.0147,
          ),
          // SizedBox(
          //   height: height * 0.0295,
          // ),
          // ConstrainedBox(
          //   constraints: BoxConstraints.tightFor(
          //       height: height * 0.0382, width: width * 0.33),
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //         side: BorderSide(color: buttonColor),
          //         shadowColor: Colors.transparent,
          //         elevation: 0,
          //         primary: Theme.of(context).backgroundColor,
          //         onPrimary: Theme.of(context).primaryColor,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(8))),
          //     child: Container(
          //       child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Image.asset(
          //               "assets/icons/Edit.png",
          //               height: width * 0.0426,
          //             ),
          //             Text("Ch???nh s???a", style: mediumPinkBodyTextStyle),
          //           ]),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void pickImageFromGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image.path;

      print(imagePath);
      if (imagePath != null) {
        Provider.of<ChangeInformationProvider>(context, listen: false)
            .getAvatarUrl(imagePath!, context);
      }
    }
  }

  void pickImageFromCamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null){
      imagePath = image.path;
      // print(imagePath);
      if (imagePath != null) {
        Provider.of<ChangeInformationProvider>(context, listen: false)
            .getAvatarUrl(imagePath!, context);
      }
    } 
  }
}
