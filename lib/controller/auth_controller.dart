import 'package:attendance/controller/attendance_controller.dart';
import 'package:attendance/controller/db_controller.dart';
import 'package:attendance/model/user_data_model.dart';
import 'package:attendance/view/screens/DashboardScreen.dart';
import 'package:attendance/view/screens/Error_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/instance_manager.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DbController dbController = Get.put(DbController());
  AttendanceController attendanceController = Get.put(AttendanceController());
  String email = '', password = '', error = '';
  UserDataModel userDataModel = UserDataModel();
  login() async {
    try {
      var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      attendanceController.userDataModel =
          await dbController.getUserData(user.user?.uid);
      attendanceController.update();
      Get.off(() => DashboardScreen());
    } on FirebaseAuthException catch (e) {
      // print(e.message);
      Get.off(() => ErrorScreen(error: e.message!.toString()));
    }
  }
}
