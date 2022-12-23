import 'package:attendance/controller/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);
  final AttendanceController _attendanceController =
      Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    _attendanceController.countHours();
    return Scaffold(
      body: GetBuilder<AttendanceController>(builder: (attendanceController) {
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  attendanceController.saveAttendance();
                },
                child: Text('Scan to Check in/ check out'),
              ),
              SizedBox(
                height: 40,
              ),
              Text('Welcome'),
              SizedBox(
                height: 10,
              ),
              Text('${attendanceController.userDataModel.name}',
                  style: TextStyle(fontSize: 28, color: Colors.orange)),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dashBoardCard('Today Hours', '8 h'),
                  _dashBoardCard('This Month Hours', '8 h')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dashBoardCard('Reports', ''),
                  _dashBoardCard('Total Hours', '8 h')
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _dashBoardCard(title, value) {
    return Card(
      child: Container(
          height: 150,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$title'),
                Text('$value'),
              ],
            ),
          )),
    );
  }
}
