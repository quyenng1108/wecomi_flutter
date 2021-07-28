import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/login_related_button.dart';
import 'package:wecomi_flutter/components/signup_textfield.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/view_models/service_view_models/forgot_password_provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
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
          physics: NeverScrollableScrollPhysics(),
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
                    "Lấy lại mật khẩu",
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
                      "Vui lòng nhập email của bạn để nhận hướng dẫn lấy lại mật khẩu.",
                      style: regularExtraLightBlackBodyTextStyle),
                ),
                SizedBox(
                  height: height * 0.0886,
                ),
                SignupTextField(
                  inputAction: TextInputAction.done,
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                  hintText: "Email",
                  onChanged: (String value) =>
                      forgotPasswordProvider.validateEmail(value),
                  focusedBorder: forgotPasswordProvider.email.error != null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1))
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF4E5EC), width: 1),
                        ),
                  enabledBorder: forgotPasswordProvider.email.error != null
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xffF23053), width: 1),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                  onErrorWidget: forgotPasswordProvider.email.error != null
                      ? Container(
                          padding: standardSpacing * 2,
                          height: height * 0.0221,
                          child: Text(
                            forgotPasswordProvider.email.error!,
                            style: smallRegularBodyTextStyle.copyWith(
                                color: buttonColor),
                          ))
                      : Container(
                          height: 0,
                        ),
                ),
                SizedBox(
                  height: height * 0.0295,
                ),
                Center(
                  child: LoginRelatedButton(
                    label: "Tiếp theo",
                    onPressed: () => forgotPasswordProvider.submitForgotPassword(),
                  ),
                ),
                SizedBox(
                  height: height * 0.1662,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
