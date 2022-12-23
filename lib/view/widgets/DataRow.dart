import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

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
                        style: TextStyle(color: buttoncolor, fontSize: 18.sp),
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
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
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
