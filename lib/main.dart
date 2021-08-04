import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:wecomi_flutter/components/signup_textfield.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/view_models/service_view_models/comic_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/forgot_password_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/signup_provider.dart';
import 'package:wecomi_flutter/view_models/ui_view_models/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/views/account/account_screen.dart';
import 'package:wecomi_flutter/views/forgot_password.dart/email_sent_screen.dart';
import 'package:wecomi_flutter/views/forgot_password.dart/forgot_password_screen.dart';
import 'package:wecomi_flutter/views/forgot_password.dart/password_change_screen.dart';
import 'package:wecomi_flutter/views/login/login_screen.dart';
import 'package:wecomi_flutter/views/main_screen.dart';
import 'package:wecomi_flutter/views/see_all_screen/see_all_screen.dart';
import 'package:wecomi_flutter/views/signup/signup_screen.dart';
import 'package:wecomi_flutter/views/splash_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => SignupProvider()),
      ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => ComicProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
      return MaterialApp(
        key: appProvider.key,
        debugShowCheckedModeBanner: false,
        navigatorKey: appProvider.navigatorKey,
        title: "Wecomi",
        theme: appProvider.theme,
        darkTheme: ThemeConfig.darkTheme,
        home: AccountScreen(),
      );
    });
  }
}
