import 'package:attendance/controller/attendance_controller.dart';
import 'package:attendance/view/screens/daily_report_Screen.dart';
import 'package:attendance/view/screens/monthly_report_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class ReportTab extends StatelessWidget {
  AttendanceController _attendanceController = Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    _attendanceController.countHours();
    _attendanceController.generateMonthlyReport();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primarycolor,
        appBar: AppBar(
          backgroundColor: buttoncolor,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Daily",
              ),
              // Tab(
              //   text: "Weekly",
              // ),
              Tab(
                text: "Monthly",
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(children: [
                DailyReport(),
                MonthlyReport(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
