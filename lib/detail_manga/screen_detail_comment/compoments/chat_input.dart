import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/theme.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.mic, color: kPrimaryColor),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20 * 0.75),
                height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_dissatisfied_outlined,
                      
                    ),
                    SizedBox(width: 20 / 4),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Tpye Message", border: InputBorder.none),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      
                    ),
                    SizedBox(width: 20.0 / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
