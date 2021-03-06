import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wecomi_flutter/models/signup_validation_model.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordProvider with ChangeNotifier {
   SignupValidationModel _email = SignupValidationModel(null, null);
  SignupValidationModel _password = SignupValidationModel(null, null);
  SignupValidationModel _passwordConfirmation =
      SignupValidationModel(null, null);
  SignupValidationModel _matchedPassword = SignupValidationModel(null, null);
  String? tmp;
  SignupValidationModel get email => _email;
  SignupValidationModel get password => _password;
  SignupValidationModel get passwordConfirmation => _passwordConfirmation;
  SignupValidationModel get matchededPassword => _matchedPassword;
  bool get isValid {
    if (_email.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void validateEmail(String value) {
    bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    // print("hi");
    print(isValid);
    if (isValid) {
      _email = SignupValidationModel(value, null);
    } else {
      _email =
          SignupValidationModel(null, "Vui lòng nhập đúng định dạng email");
    }
    notifyListeners();
  }
    void validatePassword(String value) {
    if (value.length >= 6) {
      _password = SignupValidationModel(value, null);
    } else {
      _password = SignupValidationModel(null, "Mật khẩu ít nhất 6 ký tự");
    }
    // print(_password.value);
    notifyListeners();
  }

  void validatePasswordConfirmation(String value) {
    if (value == _password.value) {
      _passwordConfirmation = SignupValidationModel(value, null);
      tmp = value;
    } else {
      _passwordConfirmation =
          SignupValidationModel(null, "Mật khẩu không khớp");
      tmp = value;
    }
    // print(_password.value);
    // print(tmp);
    notifyListeners();
  }

  void checkPasswordConfirmation(String value) {
    // print(_passwordConfirmation.value);
    if (tmp != null) {
      if (tmp == value) {
        _passwordConfirmation = SignupValidationModel(value, null);
      } else {
        _passwordConfirmation =
            SignupValidationModel(null, "Mật khẩu không khớp");
      }
    }
    notifyListeners();
  }

  Future<void> submitForgotPassword() async {
    String url = "http://117.103.207.22:8082/account/sendEmailForgotPassword";
    Map body = {"accountName": _email.value};
    final uri = Uri.parse(url);
    if (isValid) {
      final res = await http.post(uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));
      print(res.body);
    } else {
      print("hok dc dau");
    }
    notifyListeners();
  }
}
