import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_api_app/controller/database.dart';
import 'package:login_api_app/screen/login_info_screen.dart';

class LoginController extends GetxController {
  TextEditingController useridController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isObscure = true.obs;

  void onLoginButtonPressed() async {
    String userid = useridController.text;
    String password = passwordController.text;

    DatabaseHelper helper = DatabaseHelper();
    await helper.insertUser(userid, password); // Insert into database
    Get.to(() => const LoginInfo());
  }
}
