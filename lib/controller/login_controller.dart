import 'package:attendance/controller/attendance_controller.dart';
import 'package:attendance/view/screens/Error_Screen.dart';
import 'package:attendance/view/screens/dash_board.dart';
import 'package:attendance/controller/db_controller.dart';
import 'package:attendance/controller/error_page.dart';
import 'package:attendance/model/user_data_model.dart';
import 'package:attendance/view/screens/DashboardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  DbController dbController = Get.put(DbController());
  AttendanceController attendanceController = Get.put(AttendanceController());
  String email = '', password = '', error = '';
  UserDataModel userDataModel = UserDataModel();
  login(email, password) async {
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      attendanceController.userDataModel =
          await dbController.getUserData(user.user?.uid);
      attendanceController.update();
      Get.off(() => DashboardScreen());
    } on FirebaseAuthException catch (e) {
      // print(e.message);
      Get.off(() => ErrorScreen(error: e.message!.toString()));
    }
  }
}
