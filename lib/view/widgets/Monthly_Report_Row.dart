import 'package:attendance/view/screens/monthly_report_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class MonthlyReportDataRow extends StatelessWidget {
  const MonthlyReportDataRow({
    Key? key,
    required this.month,
    required this.total_hours,
  }) : super(key: key);

  final String month;
  final String total_hours;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                month,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              )),
              Expanded(
                  child: Text(
                total_hours,
                textAlign: TextAlign.center,
                style: TextStyle(color: buttoncolor, fontSize: 14.sp),
              )),
              Expanded(
                  child: TextButton(
                onPressed: () =>
                    {Get.to(MonthlyReportDetail(), arguments: month)},
                child: Text(
                  "Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      decoration: TextDecoration.underline),
                ),
              )),
            ],
          ),
        ),
        Container(
          color: linecolor,
          width: 0.91.sw,
          height: 1.h,
        )
      ],
    );
  }
}
