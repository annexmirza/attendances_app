import 'package:attendance/controller/attendance_controller.dart';
import 'package:attendance/view/widgets/Monthly_Report_Row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MonthlyReport extends StatelessWidget {
  final AttendanceController _attendanceController =
      Get.put(AttendanceController());
  Widget build(BuildContext context) {
    _attendanceController.generateMonthlyReport();
    return GetBuilder<AttendanceController>(builder: (controller) {
      return controller.monthlyReport.length > 0
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
                        "",
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
                        //     Expanded(
                        //         child: InkWell(
                        //             onTap: () {
                        //               Get.to(ErrorScreen());
                        //             },
                        //             child: Text(
                        //               "Average Checkout",
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 16.sp,
                        //                   fontWeight: FontWeight.bold),
                        //             ))),
                        //   ],
                        // ),
                        for (var i = 0;
                            i < controller.monthlyReport.length;
                            i++)
                          MonthlyReportDataRow(
                              month: controller.monthlyReport[i]['month'],
                              total_hours: controller.monthlyReport[i]
                                  ['total_hours'])
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}
