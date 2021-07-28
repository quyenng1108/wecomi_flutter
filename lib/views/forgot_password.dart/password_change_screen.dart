import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/login_related_button.dart';
import 'package:wecomi_flutter/components/signup_textfield.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/view_models/service_view_models/forgot_password_provider.dart';

class PasswordChangeScreen extends StatefulWidget {
  @override
  _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  bool _showPassword = false;
  bool _showPasswordConfirmation = false;

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
            child: Consumer<ForgotPasswordProvider>(
                builder: (context, forgotPasswordProvider, child) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(),
                        SizedBox(
                          height: height * 0.0295,
                        ),
                        Padding(
                          padding: standardSpacing,
                          child: Text(
                            "Tạo mật khẩu khẩu mới",
                            style: smallHeadingTextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.0098,
                        ),
                        Padding(
                          padding: standardSpacing,
                          child: Text(
                              "Mật khẩu mới tối thiểu 6 kí tự và khác với mật khẩu bạn sử dụng trước đó.",
                              style: regularExtraLightBlackBodyTextStyle),
                        ),
                        SizedBox(
                          height: height * 0.0886,
                        ),
                        SignupTextField(
                          inputAction: TextInputAction.next,
                          hintText: "Mật khẩu",
                          nextFocus: () => FocusScope.of(context).nextFocus(),
                          onChanged: (String value) {
                            forgotPasswordProvider.validatePassword(value);
                            forgotPasswordProvider.checkPasswordConfirmation(value);
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
                          focusedBorder: forgotPasswordProvider.password.error != null
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Color(0xffF23053), width: 1))
                              : OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Color(0xffF4E5EC), width: 1),
                                ),
                          enabledBorder: forgotPasswordProvider.password.error != null
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Color(0xffF23053), width: 1),
                                )
                              : OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                          onErrorWidget: forgotPasswordProvider.password.error != null
                              ? Container(
                                  padding: standardSpacing * 2,
                                  height: height * 0.0221,
                                  child: Text(
                                    forgotPasswordProvider.password.error!,
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
                          onChanged: (String value) => forgotPasswordProvider
                              .validatePasswordConfirmation(value),
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
                                _showPasswordConfirmation =
                                    !_showPasswordConfirmation;
                              });
                            },
                          ),
                          focusedBorder:
                              forgotPasswordProvider.passwordConfirmation.error != null
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Color(0xffF23053), width: 1))
                                  : OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Color(0xffF4E5EC), width: 1),
                                    ),
                          enabledBorder:
                              forgotPasswordProvider.passwordConfirmation.error != null
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Color(0xffF23053), width: 1),
                                    )
                                  : OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                          onErrorWidget:
                              forgotPasswordProvider.passwordConfirmation.error != null
                                  ? Container(
                                      padding: standardSpacing * 2,
                                      height: height * 0.0221,
                                      child: Text(
                                        forgotPasswordProvider
                                            .passwordConfirmation.error!,
                                        style: smallRegularBodyTextStyle
                                            .copyWith(color: buttonColor),
                                      ))
                                  : Container(
                                      height: height * 0,
                                    ),
                        ),
                        SizedBox(
                          height: height * 0.0886,
                        ),
                        Center(
                          child: LoginRelatedButton(
                            label: "Hoàn tất",
                            onPressed: (){
                              
                            },
                          ),
                        )
                      ],
                    ))),
      )),
    );
  }
}
