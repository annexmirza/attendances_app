import 'package:attendance/constants.dart';
import 'package:attendance/controller/auth_controller.dart';
import 'package:attendance/controller/qr_controller.dart';
import 'package:attendance/controller/statecontroller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'LoginScanResult.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final StateController stateController = Get.put(StateController());
  // final QrController qrController = Get.put(QrController());
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    // qrController.qrPause();

    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
          backgroundColor: primarycolor,
          body: Column(
            children: [
              Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                controller: authController.emailController,
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Colors.white))),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                controller: authController.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Colors.white))),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    authController.login();
                  },
                  child: Text('Login')),
            ],
          ));
    });
  }
}
