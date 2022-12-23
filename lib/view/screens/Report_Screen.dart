import 'package:attendance/view/widgets/Report_Tab.dart';

import 'package:flutter/material.dart';



import '../../constants.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: ReportTab(),
    );
  }
}
