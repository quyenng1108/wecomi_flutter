import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/view_models/service_view_models/comic_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/local_auth_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';
import 'package:wecomi_flutter/views/account/account_screen.dart';
import 'package:wecomi_flutter/views/login/login_screen.dart';
import 'package:wecomi_flutter/views/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AppSession().saveSession();
    AppSession().getLoginData();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<LocalAuthProvider>(context, listen: false)
          .checkLocalAuthStat();
    });
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffFBEEF4),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.2709,
            ),
            Center(
                child: Image.asset("assets/images/Splash-Logo.png",
                    width: width * 0.2266)),
            SizedBox(
              height: height * 0.0394,
            ),
            Center(
                child: Image.asset("assets/icons/Logo.png",
                    width: width * 0.5733)),
          ],
        ),
      ),
    );
  }
}
