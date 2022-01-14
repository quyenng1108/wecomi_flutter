import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/login_related_button.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/views/main_screen.dart';

class EmailSentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackButton(
                color: darkGrey,
              ),
            ),
            SizedBox(
              height: height * 0.1626,
            ),
            Image.asset("assets/icons/Email.png", width: width * 0.3626),
            SizedBox(
              height: height * 0.0394,
            ),
            Text("Kiểm tra Email của bạn", style: smallHeadingTextStyle),
            SizedBox(
              height: height * 0.0098,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.112),
                child: Text(
                  "Chúng tôi đã gửi một mật khẩu xác nhận qua email của bạn.",
                  style: regularExtraLightBlackBodyTextStyle,
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: height * 0.0886,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1546),
              child: LoginRelatedButton(
                label: "Đi tới email",
                onPressed: () {},
              ),
            ),
            Flexible(
                child: Padding(
              padding: EdgeInsets.only(
                  bottom: 20, left: width * 0.1173, right: width * 0.1173),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: regularExtraLightBlackBodyTextStyle,
                      children: [
                        TextSpan(
                            text:
                                "Bạn không nhận được email? Kiểm tra lại hoặc "),
                        TextSpan(
                            text: "Nhập một địa chỉ emal khác.",
                            style: mediumBodyTextStyle.copyWith(
                                color: buttonColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pop(context))
                      ]),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
