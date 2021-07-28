import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/login_related_button.dart';
import 'package:wecomi_flutter/components/signup_textfield.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/view_models/service_view_models/signup_provider.dart';
import 'package:wecomi_flutter/views/login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

bool _showPassword = false;
bool _showPasswordConfirmation = false;

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Consumer<SignupProvider>(
              builder: (context, signupProvider, child) {
            return Column(
              children: [
                CustomBackButton(),
                SizedBox(height: height * 0.0344),
                Image.asset("assets/icons/Logo.png", height: height * 0.0344),
                SizedBox(height: height * 0.0591),
                SignupTextField(
                  inputAction: TextInputAction.next,
                  hintText: "Họ tên",
                  nextFocus: () => FocusScope.of(context).nextFocus(),
                  onChanged: (String value) =>
                      signupProvider.validateName(value),
                  focusedBorder: signupProvider.name.error != null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1))
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF4E5EC), width: 1),
                        ),
                  enabledBorder: signupProvider.name.error != null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                  onErrorWidget: signupProvider.name.error != null
                      ? Container(
                          padding: standardSpacing * 2,
                          height: height * 0.0221,
                          child: Text(
                            signupProvider.name.error!,
                            style: smallRegularBodyTextStyle.copyWith(
                                color: buttonColor),
                          ))
                      : Container(
                          height: 0,
                        ),
                ),
                SizedBox(
                  height: height * 0.0197,
                ),
                SignupTextField(
                  inputAction: TextInputAction.next,
                  hintText: "Email",
                  nextFocus: () => FocusScope.of(context).nextFocus(),
                  onChanged: (String value) =>
                      signupProvider.validateEmail(value),
                  focusedBorder: signupProvider.email.error != null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1))
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF4E5EC), width: 1),
                        ),
                  enabledBorder: signupProvider.email.error != null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                  onErrorWidget: signupProvider.email.error != null
                      ? Container(
                          padding: standardSpacing * 2,
                          height: height * 0.0221,
                          child: Text(
                            signupProvider.email.error!,
                            style: smallRegularBodyTextStyle.copyWith(
                                color: buttonColor),
                          ))
                      : Container(
                          height: 0,
                        ),
                ),
                SizedBox(
                  height: height * 0.0197,
                ),
                SignupTextField(
                  inputAction: TextInputAction.next,
                  hintText: "Mật khẩu",
                  nextFocus: () => FocusScope.of(context).nextFocus(),
                  onChanged: (String value) {
                    signupProvider.validatePassword(value);
                    signupProvider.checkPasswordConfirmation(value);
                  },
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
                  focusedBorder: signupProvider.password.error != null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1))
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF4E5EC), width: 1),
                        ),
                  enabledBorder: signupProvider.password.error != null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                  onErrorWidget: signupProvider.password.error != null
                      ? Container(
                          padding: standardSpacing * 2,
                          height: height * 0.0221,
                          child: Text(
                            signupProvider.password.error!,
                            style: smallRegularBodyTextStyle.copyWith(
                                color: buttonColor),
                          ))
                      : Container(
                          height: height * 0,
                        ),
                ),
                SizedBox(
                  height: height * 0.0197,
                ),
                SignupTextField(
                  inputAction: TextInputAction.done,
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                  hintText: "Xác nhận mật khẩu",
                  nextFocus: () => FocusScope.of(context).nextFocus(),
                  onChanged: (String value) =>
                      signupProvider.validatePasswordConfirmation(value),
                  obscureText: !_showPasswordConfirmation,
                  suffixIcon: GestureDetector(
                    child: Container(
                      height: 24,
                      width: 24,
                      padding: EdgeInsets.all(12),
                      child: _showPasswordConfirmation
                          ? Image.asset("assets/icons/Invisible.png")
                          : Image.asset("assets/icons/Visible.png"),
                    ),
                    onTap: () {
                      setState(() {
                        _showPasswordConfirmation = !_showPasswordConfirmation;
                      });
                    },
                  ),
                  focusedBorder: signupProvider.passwordConfirmation.error !=
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
                  enabledBorder: signupProvider.passwordConfirmation.error !=
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
                  onErrorWidget:
                      signupProvider.passwordConfirmation.error != null
                          ? Container(
                              padding: standardSpacing * 2,
                              height: height * 0.0221,
                              child: Text(
                                signupProvider.passwordConfirmation.error!,
                                style: smallRegularBodyTextStyle.copyWith(
                                    color: buttonColor),
                              ))
                          : Container(
                              height: height * 0,
                            ),
                ),
                SizedBox(
                  height: height * 0.0591,
                ),
                LoginRelatedButton(
                    label: "Đăng ký",
                    onPressed: () {
                      signupProvider.submitData();
                    }),
                SizedBox(
                  height: height * 0.1859,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Bạn đã có tài khoản?", style: regularBodyTextStyle),
                    SizedBox(
                      width: width * 0.0133,
                    ),
                    GestureDetector(
                      child: Text(
                        "Đăng nhập",
                        style: mediumBodyTextStyle.copyWith(
                            color: Color(0xff5E3A78)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ],
            );
          }),
        ),
      )),
    );
  }
}
