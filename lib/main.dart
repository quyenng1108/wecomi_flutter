import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/view_models/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/views/main_screen.dart';
void main() {
  runApp(
    MultiProvider(providers: [
    ChangeNotifierProvider(create:(_) => AppProvider())],
      child: MyApp(),
    )
  );
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context,appProvider,child){
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: "Wecomi",
          theme: themeData(appProvider.theme),
          darkTheme: themeData(ThemeConfig.darkTheme),
          home: MainScreen(),
        );
      }
    );
  }
  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: theme.textTheme,
    );
  }
}
