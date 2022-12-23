import 'package:attendance/controller/attendance_controller.dart';
import 'package:attendance/view/widgets/Report_Data_Row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class MonthlyReportDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(builder: (controller) {
      return Scaffold(
        backgroundColor: primarycolor,
        appBar: AppBar(
          backgroundColor: buttoncolor,
          title: Text(Get.arguments.toString()),
        ),
        body: SafeArea(
          child: controller.dailyReport.length > 0
              ? Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Date",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          )),
                          Expanded(
                              child: Text(
                            "Hours",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          )),
                          Expanded(
                              child: Text(
                            "Checkin",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          )),
                          Expanded(
                              child: Text(
                            "Checkout",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 480.h,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var i = controller.dailyReport.length - 1;
                                i >= 0;
                                i--)
                              if (controller.dailyReport[i]['month'] ==
                                  Get.arguments.toString())
                                SizedBox(
                                    child: ReportDataRow(
                                  date: controller.dailyReport[i]['Date'],
                                  check_in:
                                      i != controller.dailyReport.length - 1 ||
                                              controller.todayCheckIn.length ==
                                                  0
                                          ? controller.dailyReport[i]['CheckIn']
                                          : controller.todayCheckIn,
                                  check_out: controller.dailyReport[i]
                                          ['CheckOut']
                                      .toString(),
                                  total_hours:
                                      i != controller.dailyReport.length - 1 ||
                                              controller.todayCheckIn.length ==
                                                  0
                                          ? controller.dailyReport[i]['Hours']
                                          : controller.todayWorkTime,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      );
    });
  }
}
