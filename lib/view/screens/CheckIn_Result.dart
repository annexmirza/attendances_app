import 'package:attendance/controller/attendance_controller.dart';
import 'package:attendance/controller/statecontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import 'CheckIn_Screen.dart';
import 'ConfirmChekin.dart';

class CheckinResult extends StatelessWidget {
  CheckinResult({Key? key}) : super(key: key);
  // AttendanceController _attendanceController = Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    StateController stateController = Get.put(StateController());
    return GetBuilder<AttendanceController>(builder: (attendanceController) {
      return attendanceController.qrError
          ? Scaffold(
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
                    // SizedBox(
                    //   height: 0.04.sh,
                    // ),
                    InkWell(
                        onTap: () {
                          stateController.iscorrect = true;
                        },
                        child: Container(
                            child: Text(
                          "Oops",
                          style: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ))),
                    Container(
                        child: Text(
                      "Something Went Wrong.",
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
                        attendanceController.getUserData();
                        // stateController.iscorrect = false;
                        Get.offAll(() => CheckinScreen());
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
                    ),

                    /*Scanning Image*/
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    InkWell(
                      onTap: () {
                        attendanceController.goToDashBoard();
                      },
                      child: Container(
                        height: 45.h,
                        width: 170.w,
                        child: Center(
                            child: Text(
                          "Dashboard",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        decoration: BoxDecoration(
                          color: buttoncolor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    )
                  ],
                ),
              ))
          : ConfirmCheckin();
    });
  }
}
