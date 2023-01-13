import 'package:attendance/controller/attendance_controller.dart';
import 'package:attendance/controller/db_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../constants.dart';

class CheckinScreen extends StatelessWidget {
  CheckinScreen({Key? key}) : super(key: key);
  final AttendanceController _attendanceController =
      Get.put(AttendanceController());

  @override
  // DbController _dbController = Get.put(DbController());
  Widget build(BuildContext context) {
    _attendanceController.qrPause();
    _attendanceController.getUserData();
    return GetBuilder<AttendanceController>(builder: (attendanceController) {
      return Scaffold(
          backgroundColor: primarycolor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Text(
                  "Scan to",
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
                  height: 0.03.sh,
                ),
                /*Scanning Image*/
                Container(
                  height: 0.4.sh,
                  width: 0.6.sw,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: QRView(
                          key: attendanceController.qrAttendanceKey,
                          onQRViewCreated:
                              attendanceController.onQRViewCreated),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.03.sh,
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
                      "DashBoard",
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
          ));
    });
    ;
  }
}
