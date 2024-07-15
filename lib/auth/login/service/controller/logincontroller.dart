import 'package:auth/auth/login/model/usermodel.dart';
import 'package:auth/config/typedef.dart';
import 'package:auth/config/util/error/apifailure.dart';
import 'package:auth/config/util/error/failure.dart';
import 'package:auth/core/constants.dart';
import 'package:auth/core/helper/helperfunctions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LoginController with ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _Textfieldchange = false;
  bool _Loginactivated = false;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  bool get Textfieldchange => _Textfieldchange;
  bool get Loginactivated => _Loginactivated;
  void Textfieldchangechangeismade() {
    _Textfieldchange = true;
    notifyListeners();
  }

  void changeLoginStatus() {
    _Loginactivated = !_Loginactivated;
    notifyListeners();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  User? userdata;

  FutureResult<bool> Login() async {
    print("Printing textfield values");
    print(_emailController.text);
    if (_emailController.text == "" || _passwordController.text == "") {
      return Left(ApiFailure(message: "Fields not valid", statusCode: 600));
    }
    try {
      print("Inside Login");
      changeLoginStatus();
      String jsonString = await rootBundle.loadString(Apipath);

      await Future.delayed(Duration(seconds: 5));

      Map<String, dynamic> jsonResponse = json.decode(jsonString);

      print(jsonString);
      User userdata = User.fromMap(jsonResponse);

      if (userdata?.Email != null) {
        if (Compare(userdata.Email, _emailController.text) &&
            Compare(userdata.Password, _passwordController.text)) {
          print("Succesful Comparision");
          changeLoginStatus();
          return Right(true);
        } else {
          changeLoginStatus();
          return Left(ApiFailure(
              message: "Incorrect user credentials", statusCode: 401));
        }
      } else {
        changeLoginStatus();
        return Left(
            ApiFailure(message: "Failed to fetch data", statusCode: 404));
      }
    } catch (e) {
      changeLoginStatus();
      return Left(ApiFailure(message: "Server Error", statusCode: 500));
    }
  }

  // FutureResult<bool> EmailValidate(String email) async {
  //   if (EmailValidator.validate(email)) {
  //     return Right(true);
  //   } else {
  //     return Left(ApiFailure(message: "Email not valid"));
  //   }
  // }

  String? EmailValidate(String? email) {
    if (EmailValidator.validate(email ?? "")) {
      return null;
    } else {
      return "Email not valid";
    }
  }

  String? PasswordValidate(String? password) {
    if (password!.length > 5) {
      return null;
    } else {
      return "Password should be atleast 5 characters";
    }
  }
}
