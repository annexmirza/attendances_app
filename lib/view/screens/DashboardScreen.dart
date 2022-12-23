import 'package:attendance/controller/attendance_controller.dart';
import 'package:attendance/controller/notification_controller.dart';
import 'package:attendance/view/screens/CheckIn_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import 'Report_Screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);
  final AttendanceController _attendanceController =
      Get.put(AttendanceController());
  final NotificationController _notificationController =
      Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    _attendanceController.countHours();
    _attendanceController.getUserData();

    // String totalHours = "09:06";
    // String todayHours = "09:06";
    // String monthlyHours = "09:06";
    // String averageCheckinTime = "09:06";
    // String averageCheckoutTime = "09:06";
    // String earkierCheckinTime = "09:06";
    // String earkierCheckoutTime = "09:06";

    // String name = "Asfandyar Khan";
    return Scaffold(
      backgroundColor: primarycolor,
      body: GetBuilder<AttendanceController>(builder: (attendanceController) {
        return Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
              /*Monthly hours top text*/
              child: Row(
                children: [
                  // InkWell(
                  //   onTap: () {

                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Container(
                  //       child: Text(
                  //         "Mark Attendance",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 14.sp),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     FirebaseAuth.instance.signOut();
                  //     Get.offAll(LoginScreen());
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Container(
                  //       child: Text(
                  //         "Logout",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 14.sp),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(child: Container()),
                  Container(
                      child: Text(
                    "${DateFormat('dd  MMM-yy').format(DateTime.now())}",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),

            /*Name of candidate*/
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      child: Text(
                    "${attendanceController.userDataModel.name}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp),
                  )),
                  SizedBox(
                    width: 5.w,
                  ),
                  CircleAvatar(
                    radius: 5.sp,
                    backgroundColor: Color(0xFF0EAF00),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),

            /*First Row*/

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Container(
                height: 60.h,
                decoration: BoxDecoration(
                    color: attendanceController.todayAttendance != null
                        ? Color(0xFF0EAF00)
                        : buttoncolor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: attendanceController.todayAttendance != null
                                ? Color(0xFF0EAF00)
                                : buttoncolor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Column(
                            children: [
                              Container(
                                  child: Text(
                                "Today Checkin",
                                style: TextStyle(
                                    color: primarycolor, fontSize: 14.sp),
                              )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                  child: Text(
                                "${attendanceController.todayCheckIn}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: 60.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Column(
                            children: [
                              Container(
                                  child: Text(
                                "Today's Hours",
                                style: TextStyle(
                                    color: primarycolor, fontSize: 14.sp),
                              )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                  child: Text(
                                "${attendanceController.todayWorkTime}",
                                style: TextStyle(
                                    color:
                                        attendanceController.todayAttendance !=
                                                null
                                            ? Color(0xFF0EAF00)
                                            : buttoncolor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: attendanceController.todayAttendance != null
                                ? Color(0xFF0EAF00)
                                : buttoncolor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Column(
                            children: [
                              Container(
                                  child: Text(
                                "Today Checkout",
                                style: TextStyle(
                                    color: primarycolor, fontSize: 14.sp),
                              )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                  child: Text(
                                "${attendanceController.todayCheckOut}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*Row to show  Average CheckIn Checkout*/
            // DataRow(
            //     title1: "Average Checkin time",
            //     title2: "Average Checkout time",
            //     average_checkin_time: attendanceController.averageCheckIn,
            //     average_checkout_time: attendanceController.averageCheckOut),
            // /*Row to show Earkier CheckIn Checkout*/
            // DataRow(
            //     title1: "Earlier Checkin time",
            //     title2: "latest Checkout time",
            //     average_checkin_time: attendanceController.earliestCheckIn,
            //     average_checkout_time: attendanceController.latestCheckOut),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () {
                attendanceController.getUserData();
                Get.off(() => CheckinScreen());
              },
              child: Container(
                height: 45.h,
                width: 170.w,
                child: Center(
                    child: Text(
                  attendanceController.todayAttendance != null &&
                          attendanceController.todayAttendance.checkIn != "-"
                      ? "Check Out"
                      : "Check In",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                decoration: BoxDecoration(
                  color: attendanceController.todayAttendance != null
                      ? Color(0xFF0EAF00)
                      : buttoncolor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Get.to(ReportScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    "Details",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 70.h,
            // ),
            // InkWell(
            //   onTap: () {
            //     Get.to(ReportScreen());
            //   },
            //   child: Container(
            //     height: 45.h,
            //     width: 170.w,
            //     child: Center(
            //         child: Text(
            //       "Reports",
            //       textAlign: TextAlign.center,
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     )),
            //     decoration: BoxDecoration(
            //       color: buttoncolor,
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //   ),
            // )
          ],
        );
      }),
    );
  }
}

/*DataCustom Row dget*/

class DataRow extends StatelessWidget {
  const DataRow({
    Key? key,
    required this.average_checkin_time,
    required this.average_checkout_time,
    required this.title1,
    required this.title2,
  }) : super(key: key);
  final String title1;
  final String title2;
  final String average_checkin_time;
  final String average_checkout_time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            color: buttoncolor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 60.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Column(
                    children: [
                      Container(
                          child: Text(
                        title1,
                        style: TextStyle(color: primarycolor, fontSize: 14.sp),
                      )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                          child: Text(
                        average_checkin_time,
                        style: TextStyle(
                            color: buttoncolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 60.h,
                decoration: BoxDecoration(
                    color: buttoncolor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Column(
                    children: [
                      Container(
                          child: Text(
                        title2,
                        style: TextStyle(color: primarycolor, fontSize: 14.sp),
                      )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                          child: Text(
                        average_checkout_time,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
