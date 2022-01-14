import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/login_related_button.dart';
import 'package:wecomi_flutter/components/signup_textfield.dart';
import 'package:wecomi_flutter/components/standard_textfield.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/utils/loading_dialog.dart';
import 'package:wecomi_flutter/view_models/service_view_models/local_auth_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';
import 'package:wecomi_flutter/views/forgot_password.dart/forgot_password_screen.dart';
import 'package:wecomi_flutter/views/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  String? accessToken;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    bool isUsingLocalAuth =
        context.select((LocalAuthProvider p) => p.isUsingLocalAuth);
    print("hehehe $isUsingLocalAuth");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: darkGrey,
        ),
      ),
      // resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Consumer<LoginProvider>(
            builder: (context, loginProvider, child) => Column(
              children: [
                Image.asset("assets/images/Signin_logo.png", height: 190),
                SizedBox(height: 16),
                SignupTextField(
                  controller: _usernameTextController,
                  inputAction: TextInputAction.next,
                  hintText: "Họ tên",
                  nextFocus: () => FocusScope.of(context).nextFocus(),
                  focusedBorder: loginProvider
                              .invalidUsernameAccount.invalidUsernameMessage !=
                          null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1))
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF4E5EC), width: 1),
                        ),
                  enabledBorder: loginProvider
                              .invalidUsernameAccount.invalidUsernameMessage !=
                          null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                  onErrorWidget: loginProvider
                              .invalidUsernameAccount.invalidUsernameMessage !=
                          null
                      ? Container(
                          padding: standardSpacing * 2,
                          height: height * 0.0221,
                          child: Text(
                            loginProvider
                                .invalidUsernameAccount.invalidUsernameMessage!,
                            style: smallRegularBodyTextStyle.copyWith(
                                color: buttonColor),
                          ))
                      : Container(
                          height: 0,
                        ),
                ),
                SizedBox(
                  height: 12,
                ),
                SignupTextField(
                  controller: _passwordTextController,
                  inputAction: TextInputAction.done,
                  hintText: "Mật khẩu",
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                  obscureText: !_showPassword,
                  suffixIcon: GestureDetector(
                    child: Container(
                      height: 24,
                      width: 24,
                      padding: EdgeInsets.all(12),
                      child: _showPassword
                          ? Image.asset("assets/icons/Invisible.png")
                          : Image.asset("assets/icons/Visible.png"),
                    ),
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  focusedBorder: loginProvider
                              .invalidPasswordAccount.invalidPasswordMessage !=
                          null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1))
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF4E5EC), width: 1),
                        ),
                  enabledBorder: loginProvider
                              .invalidPasswordAccount.invalidPasswordMessage !=
                          null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                  onErrorWidget: loginProvider
                              .invalidPasswordAccount.invalidPasswordMessage !=
                          null
                      ? Container(
                          padding: standardSpacing * 2,
                          height: height * 0.0221,
                          child: Text(
                            loginProvider
                                .invalidPasswordAccount.invalidPasswordMessage!,
                            style: smallRegularBodyTextStyle.copyWith(
                                color: buttonColor),
                          ))
                      : Container(
                          height: height * 0,
                        ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                GestureDetector(
                    child: Container(
                      width: width,
                      padding: standardSpacing,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Quên mật khẩu?",
                          style: smallRegularBodyTextStyle.copyWith(
                              color: Color(0xff5E3A78)),
                        ),
                      ),
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()))),
                SizedBox(
                  height: height * 0.0295,
                ),
                LoginRelatedButton(
                    label: "Đăng nhập",
                    onPressed: () {
                      LoadingDialog().buildShowDialog(context);
                      loginProvider.loginWithEmail(_usernameTextController.text,
                          _passwordTextController.text, context);
                    }),
                SizedBox(
                  height: height * 0.0197,
                ),
                isUsingLocalAuth
                    ? IconButton(
                        onPressed: () {
                          context.read<LocalAuthProvider>().loginWithLocalAuth(
                              AppSession().username!,
                              AppSession().password!,
                              context);
                        },
                        icon: Image.asset("assets/icons/faceid.png"))
                    : SizedBox(),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: standardSpacing,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * 0.264,
                          height: 1.5,
                          color: Color(0xffE4E8EF),
                        ),
                        Text(
                          "Hoặc tiếp tục với",
                          style: regularBodyTextStyle,
                        ),
                        Container(
                          width: width * 0.264,
                          height: 1.5,
                          color: Color(0xffE4E8EF),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: width,
                  height: height * 0.0886,
                  padding: standardSpacing,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLogin(
                        image: "assets/icons/Google.png",
                        onPressed: () {
                          loginProvider.loginWithGoogle();
                        },
                      ),
                      SizedBox(
                        width: width * 0.0426,
                      ),
                      SocialLogin(
                        image: "assets/icons/Facebook.png",
                        onPressed: () {
                          // loginProvider.loginWithFacebook();
                        },
                      ),
                      if (Platform.isIOS)
                        SizedBox(
                          width: width * 0.0426,
                        ),
                      if (Platform.isIOS)
                        SocialLogin(
                          image: "assets/icons/Apple.png",
                          onPressed: () {},
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Bạn chưa có tài khoản?", style: regularBodyTextStyle),
                    SizedBox(
                      width: width * 0.0133,
                    ),
                    GestureDetector(
                      child: Text(
                        "Đăng ký",
                        style: mediumBodyTextStyle.copyWith(
                            color: Color(0xff5E3A78)),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen())),
                    )
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class SocialLogin extends StatelessWidget {
  SocialLogin({@required this.image, @required this.onPressed});
  final String? image;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 60, width: 60),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              shadowColor: Color(0xff08252B).withOpacity(.1),
              primary: Colors.white,
              onPrimary: Color(0xffE76F86),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          child: Container(
            // padding: EdgeInsets.all(width * 0.048),
            child: Image.asset(
              image!,
              width: width * 0.096,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
