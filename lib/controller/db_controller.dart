import 'package:attendance/model/attendance_model.dart';
import 'package:attendance/model/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DbController extends GetxController {
  CollectionReference attendanceCollection =
      FirebaseFirestore.instance.collection('attendance');
  getUserData(id) async {
    DocumentSnapshot employeeDoc =
        await FirebaseFirestore.instance.collection('employee').doc(id).get();
    if (employeeDoc.exists) {
      return UserDataModel.fromDocumentSnapshot(employeeDoc);
    } else
      return null;
  }

  saveAttendance(
      DateTime currentTime, List attendanceMapList, String id) async {
    await attendanceCollection
        .doc('${currentTime.month}$id${currentTime.year}')
        .set({'Attendance': attendanceMapList, 'EmployeeId': id});
  }

  getCurrentMonthAttendance(DateTime currentTime, String id) async {
    return await attendanceCollection
        .doc('${currentTime.month}$id${currentTime.year}')
        .get();
  }

  getAllAttendanceOfEmployee(String id) async {
    QuerySnapshot attendanceSnaps =
        await attendanceCollection.where('EmployeeId', isEqualTo: id).get();
    List<AttendanceModel> attendanceList = [];
    if (attendanceSnaps.docs.length > 0) {
      attendanceSnaps.docs.forEach((doc) {
        List listofMap = doc['Attendance'];
        listofMap.forEach((dayAttendance) {
          attendanceList.add(AttendanceModel.fromMap(dayAttendance));
        });
      });
      // print(attendanceList.length);
      // return attendanceList;
    }
    return attendanceList;
  }

  //***************Coloning data for test************************
//   cloneData() async {
//     List<AttendanceModel> att = [];
//     await attendanceCollection
//         .where('EmployeeId', isEqualTo: 'bLVBci7hRIQjjPeBVJuxPnFty262')
//         .get()
//         .then((value) {
//       if (value.docs.isNotEmpty) {
//         value.docs.forEach((element) {
//           List listOfMap = element['Attendance'];
//           listOfMap.forEach((e) {
//             att.add(AttendanceModel.fromMap(e));
//           });
//         });
//       }
//     });
//     List attendanceList = [];
//     att.forEach((element) {
//       if (element.month == 'Aug') {
//         attendanceList.add(element.toMap());
//       }
//     });
//     attendanceList.forEach((element) {
//       element['name'] = "test";
//       element['id'] = "DEEdQTqP7zXK8QGONJjb0Mbxccx1";
//     });
//     att.forEach((element) {
//       DateTime date = DateTime.fromMillisecondsSinceEpoch(element.date ?? 0);
//       print(date.year);
//       attendanceCollection
//           .doc('8DEEdQTqP7zXK8QGONJjb0Mbxccx1${date.year}')
//           .set({
//         'Attendance': attendanceList,
//         'EmployeeId': 'DEEdQTqP7zXK8QGONJjb0Mbxccx1'
//       }).then((value) => print('done'));
//     });
//   }
}
