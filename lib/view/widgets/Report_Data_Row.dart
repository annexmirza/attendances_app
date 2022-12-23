
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class ReportDataRow extends StatelessWidget {
  const ReportDataRow({
    Key? key,
    required this.date,
    required this.check_in,
    required this.check_out,
    required this.total_hours,
  }) : super(key: key);

  final String date;
  final String check_in;
  final String check_out;
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
                date,
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
                  child: Text(
                check_in,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: buttoncolor,
                  fontSize: 14.sp,
                ),
              )),
              Expanded(
                  child: Text(
                check_out,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
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
