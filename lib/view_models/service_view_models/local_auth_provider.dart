import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/constants/utils.dart';
import 'package:wecomi_flutter/utils/loading_dialog.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';

class LocalAuthProvider extends ChangeNotifier {
  bool isUsingLocalAuth = false;

  toggleSwitch() {
    isUsingLocalAuth = !isUsingLocalAuth;
    notifyListeners();
  }

  void authenticate() async {
    var localAuth = LocalAuthentication();
    var canCheck = await localAuth.canCheckBiometrics;
    if (isUsingLocalAuth == false) {
      if (canCheck) {
        try {
          bool didAuthenticate = await localAuth.authenticate(
              localizedReason: 'Please authenticate to show account balance',
              biometricOnly: true);
          if (didAuthenticate) {
            AppSession().saveLocalAuthStatus(true);
            isUsingLocalAuth = true;
          } else {
            print("Failed");
          }
        } on PlatformException catch (e) {
          if (e.code == auth_error.lockedOut) {}
        }
        notifyListeners();
      }
    } else {
      AppSession().saveLocalAuthStatus(false);
      isUsingLocalAuth = false;
      notifyListeners();
    }
    // notifyListeners();
  }

  void loginWithLocalAuth(
      String username, String password, BuildContext context) async {
    var localAuth = LocalAuthentication();
    var canCheck = await localAuth.canCheckBiometrics;
    if (canCheck) {
      bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          biometricOnly: true);
      if (didAuthenticate) {
        LoadingDialog().buildShowDialog(context);
        Provider.of<LoginProvider>(context, listen: false)
            .loginWithEmail(username, password, context);
      } else {
        print("Failed");
      }
    }
  }

  void onLogout(bool flag) {
    isUsingLocalAuth = flag;
    AppSession().saveLocalAuthStatus(flag);
    notifyListeners();
  }

  void checkLocalAuthStat() {
    AppSession().getLocalAuthStatus().then((value) {
      if (AppSession().usingLocalAuth) {
        isUsingLocalAuth = true;
      } else {
        isUsingLocalAuth = false;
      }
    });
    notifyListeners();
  }
}
