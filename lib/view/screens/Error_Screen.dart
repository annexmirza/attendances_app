import 'package:attendance/view/screens/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class ErrorScreen extends StatelessWidget {
  ErrorScreen({
    this.error = '',
    Key? key,
  }) : super(key: key);
  String error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 194.h,
                width: 226.w,
                decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(20)),
                child: Image.asset("assets/errorpic.png")),
            SizedBox(
              height: 15.h,
            ),
            Container(
                child: Text(
              "Ooops,\n\n Something Went Wrong",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "\n$error", textAlign: TextAlign.center,
                  // maxLines: 5,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
            SizedBox(
              height: 0.04.sh,
            ),
            /*Button */
            InkWell(
              onTap: () {
                Get.offAll(LoginScreen());
              },
              child: Container(
                height: 50.h,
                width: 190.w,
                child: Center(
                    child: Text(
                  "Go Back To Home",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff0F044C)),
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
      ),
    );
  }
}
