import 'package:attendance/constants.dart';
import 'package:attendance/controller/statecontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CheckIn_Screen.dart';
import 'Login_Screen.dart';

class LoginScanResult extends StatelessWidget {
  const LoginScanResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateController stateController = Get.put(StateController());

    return GetBuilder(
        init: stateController,
        builder: (statecontroller) {
          return Scaffold(
              backgroundColor: primarycolor,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: primarycolor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset("assets/warning.png")),
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    InkWell(
                        onTap: () {
                          stateController.issuccess = true;
                        },
                        child: Container(
                            child: Text(
                          "You Scan Wrong",
                          style: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ))),
                    Container(
                        child: Text(
                      "QR Code",
                      style: TextStyle(
                          fontSize: 25.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    InkWell(
                      onTap: () {
                        stateController.isscanned = false;

                        // FirebaseAuth.instance.currentUser != null?
                        Get.off(() => LoginScreen());
                        // : Get.off(() => CheckinScreen());
                      },
                      child: Container(
                        height: 50.h,
                        width: 170.w,
                        child: Center(
                            child: Text(
                          "Try Again",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        decoration: BoxDecoration(
                          color: buttoncolor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    )
                    /*Scanning Image*/
                  ],
                ),
              ));
        });
  }
}
