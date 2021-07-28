import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/login_related_button.dart';
import 'package:wecomi_flutter/components/standard_textfield.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/views/forgot_password.dart/forgot_password_screen.dart';
import 'package:wecomi_flutter/views/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  TextEditingController? _usernameTextController;
  TextEditingController? _passwordTextController;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                CustomBackButton(),
                SizedBox(height: height * 0.0344),
                Image.asset("assets/icons/Logo.png", height: height * 0.0344),
                SizedBox(height: height * 0.0591),
                StandardTextField(
                  controller: _usernameTextController,
                  inputAction: TextInputAction.next,
                  nextFocus: () => FocusScope.of(context).nextFocus(),
                  hintText: "Địa chỉ Email",
                ),
                SizedBox(
                  height: height * 0.0197,
                ),
                StandardTextField(
                  controller: _passwordTextController,
                  obscureText: !_showPassword,
                  suffixIcon: GestureDetector(
                    child: Container(
                      height: 24,
                      width: 24,
                      padding: EdgeInsets.all(12),
                      child: _showPassword
                          ? Image.asset("assets/icons/Visible.png")
                          : Image.asset("assets/icons/Visible.png"),
                    ),
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  inputAction: TextInputAction.done,
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                  hintText: "Mật khẩu",
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
                LoginRelatedButton(label: "Đăng nhập", onPressed: () {}),
                SizedBox(
                  height: height * 0.0197,
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
                  height: height * 0.0394,
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
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: width * 0.0426,
                      ),
                      SocialLogin(
                        image: "assets/icons/Facebook.png",
                        onPressed: () {},
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
                  height: height * 0.23,
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
          ),
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
      constraints: BoxConstraints.tightFor(
          height: height * 0.0886, width: height * 0.0886),
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
