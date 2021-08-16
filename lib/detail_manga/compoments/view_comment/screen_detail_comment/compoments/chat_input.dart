import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/theme.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Container(
      height: 65 * ratioH,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 25),
            blurRadius: 25,
            color: Colors.black,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 42 * ratioH,
              decoration: BoxDecoration(
                color: Color(0xffF4F6F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                width: 290 * ratioW,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                            hintText: "Viết bình luận của bạn ở đây...",
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Image.asset(
                "assets/images/Rocket.png",
                width: 25 * ratioW,
                height: 25 * ratioH,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
