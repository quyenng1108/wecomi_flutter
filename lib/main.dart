import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/models/followed_book.dart';
import 'package:wecomi_flutter/models/read_history.dart';
import 'package:wecomi_flutter/view_models/service_view_models/book_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/change_information_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/comment_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/follow_book_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/getchapter_byBookuuid_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wecomi_flutter/components/signup_textfield.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/view_models/service_view_models/book_detail_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/chapter_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/comic_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/forgot_password_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/genre_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/group_info_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/group_list_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/group_post_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/local_auth_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/read_history_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/search_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/signup_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/user_profile_provider.dart';
import 'package:wecomi_flutter/view_models/ui_view_models/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/views/account/account_screen.dart';
import 'package:wecomi_flutter/views/chapter_detail/chapter_detail_screen.dart';
import 'package:wecomi_flutter/views/discover/discover_screen.dart';
import 'package:wecomi_flutter/views/discover/post_comment_screen.dart';
import 'package:wecomi_flutter/views/forgot_password.dart/email_sent_screen.dart';
import 'package:wecomi_flutter/views/forgot_password.dart/forgot_password_screen.dart';
import 'package:wecomi_flutter/views/forgot_password.dart/password_change_screen.dart';
import 'package:wecomi_flutter/views/genre/genre_screen.dart';
import 'package:wecomi_flutter/views/group/group_list.dart';
import 'package:wecomi_flutter/views/home/home_screen.dart';
import 'package:wecomi_flutter/views/login/login_screen.dart';
import 'package:wecomi_flutter/views/main_screen.dart';
import 'package:wecomi_flutter/views/search/search_screen.dart';
import 'package:wecomi_flutter/views/see_all_screen/see_all_screen.dart';
import 'package:wecomi_flutter/views/signup/signup_screen.dart';
import 'package:wecomi_flutter/views/splash_screen.dart';
import 'package:wecomi_flutter/views/test.dart';
import 'package:wecomi_flutter/views/user_profile/user_profile_screen.dart';

void main() async {
  VisibilityDetectorController.instance.updateInterval = Duration.zero;
  WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences preferences = await SharedPreferences.getInstance();
// await preferences.clear();
  await Hive.initFlutter();
  Hive.registerAdapter(ReadHistoryAdapter());
  Hive.registerAdapter(FollowedBookAdapter());
  await Hive.openBox<FollowedBook>('followedBook');
  await Hive.openBox<ReadHistory>('readHistory');
  // debugPaintSizeEnabled=true;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProvider()),
      // ChangeNotifierProvider(create: (_) => BookProvider()),
      ChangeNotifierProvider(create: (_) => ChapterByBookIDProvider()),
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => SignupProvider()),
      ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => ComicProvider()),
      ChangeNotifierProvider(create: (_) => GenreProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
      ChangeNotifierProvider(create: (_) => ChapterProvider()),
      ChangeNotifierProvider(create: (_) => BookDetailProvider()),
      ChangeNotifierProvider(create: (_) => FollowBookProvider()),
      ChangeNotifierProvider(create: (_) => GroupPostProvider()),
      ChangeNotifierProvider(create: (_) => CommentProvider()),
      ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ChangeNotifierProvider(create: (_) => ReadHistoryProvider()),
      ChangeNotifierProvider(create: (_) => LocalAuthProvider()),
      ChangeNotifierProvider(create: (_) => GroupListProvider()),
      ChangeNotifierProvider(create: (_) => GroupInfoProvider()),
      ChangeNotifierProvider(create: (_) => ChangeInformationProvider()),
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
        home: SplashScreen(),
      );
    });
  }
}
