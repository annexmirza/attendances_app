import 'package:attendance/view/screens/CheckIn_Screen.dart';
import 'package:attendance/view/screens/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 640),
        builder: (BuildContext context, child) => GetMaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: landingPage(),
            ));
  }
}

Widget landingPage() {
  return LoginScreen();
  // User? user = FirebaseAuth.instance.currentUser;

  // return user == null ? LoginScreen() : CheckinScreen();
}
