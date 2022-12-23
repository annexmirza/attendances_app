import 'package:attendance/controller/attendance_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import 'DashboardScreen.dart';

class ConfirmCheckin extends StatelessWidget {
  ConfirmCheckin({Key? key}) : super(key: key);
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primarycolor,
        body: GetBuilder<AttendanceController>(builder: (controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 100.h,
                    width: 226.w,
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Image.asset("assets/thumb.png")),
                SizedBox(
                  height: 0.04.sh,
                ),
                Container(
                    child: Text(
                  "Tap to Confirm",
                  style: TextStyle(
                      fontSize: 25.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
                Container(
                    child: Text(
                  "Checkin / Checkout",
                  style: TextStyle(
                      fontSize: 25.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 0.04.sh,
                ),
                controller.isLoading
                    ? Container(
                        height: 50.h,
                        width: 50.h,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: buttoncolor,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          attendanceController.saveAttendance();
                        },
                        child: Container(
                          height: 50.h,
                          width: 170.w,
                          child: Center(
                              child: Text(
                            "Confirm",
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
          );
        }));
  }
}
