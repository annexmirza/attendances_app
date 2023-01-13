import 'dart:io';

import 'package:attendance/controller/db_controller.dart';
import 'package:attendance/controller/notification_controller.dart';
import 'package:attendance/model/attendance_model.dart';
import 'package:attendance/model/user_data_model.dart';
import 'package:attendance/view/screens/CheckIn_Result.dart';
import 'package:attendance/view/screens/DashboardScreen.dart';
import 'package:attendance/view/screens/Error_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AttendanceController extends GetxController {
  NotificationController notificationController =
      Get.put(NotificationController());
  String code = 'attendance';
  int lat = 0, long = 0;
  Position? userPosition;
  UserDataModel userDataModel = UserDataModel();
  bool dataFetched = false;
  DbController dbController = Get.put(DbController());
  List<AttendanceModel> attendanceMapList = [];
  CollectionReference attendanceCollection =
      FirebaseFirestore.instance.collection('attendance');
  var dateformat = DateFormat('yyyy:MM:dd');
  var monthformat = DateFormat('yyyy:MM');
  var timeFromat = DateFormat("hh:mm a");
  String changeMonth = "";
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  List<Map> dailyReport = [];
  List<Map> monthlyReport = [];
/* -------------------------------------------------------------------------- */
  int todayHours = 0, totalHours = 0, thisMonthHours = 0;
  String todayCheckIn = '';
  String todayCheckOut = '';
  String averageCheckIn = '',
      averageCheckOut = '',
      earliestCheckIn = '',
      latestCheckOut = '';
  String todayWorkTime = '';
  var todayAttendance;

/* -------------------------------------------------------------------------- */
  generateMonthlyReport() async {
    /* ---------------------- Monthly Attendance --------------------- */
    var monthlyAttendanceCollection = await attendanceCollection
        .where('EmployeeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    monthlyReport.clear();
    monthlyAttendanceCollection.docs.forEach((doc) {
      List listOfAttendance = doc['Attendance'];
      int monthHours = 0;
      int monthDate = 0;
      String month = listOfAttendance[0]['month'];
      listOfAttendance.forEach((element) {
        monthHours = (monthHours + element['todayMinutes']) as int;
        monthDate = (monthDate + element['date']) as int;
      });
      monthlyReport.add({
        "month": month,
        "total_hours": '${monthHours ~/ 60} h : ${monthHours % 60} min',
        "sortingDate": monthDate,
      });
    });
    var list;
    monthlyReport = monthlyReport
      ..sort((e1, e2) => e1['sortingDate'].compareTo(e2['sortingDate']));
    print(monthlyReport);
  }

  countHours() async {
    clear();
    int _todayminutes = 0, _totalminutes = 0, _thisMonthminutes = 0;
    int _latestHour = 0, _latestMinutes = 0;
    int _earliestHour = 25, _earliestMinutes = 100;
    List<int> _avgCheckInMinute = [], _avgCheckOutMinute = [];
    attendanceMapList =
        await dbController.getAllAttendanceOfEmployee(userDataModel.id ?? '');
    dailyReport.clear();
    /* ---------------------- loop fro every Day attendance --------------------- */
    attendanceMapList.forEach((dayMap) {
      var _todayDate = dateformat.format(DateTime.now());
      var _currentMonth = monthformat.format(DateTime.now());
      DateTime _checkInTime = dayMap.checkIn != null
          ? DateTime.fromMillisecondsSinceEpoch(dayMap.checkIn!)
          : DateTime.fromMillisecondsSinceEpoch(1438574736000);

      DateTime _checkOutTime = dayMap.checkOut != null
          ? DateTime.fromMillisecondsSinceEpoch(dayMap.checkOut!)
          : DateTime.fromMillisecondsSinceEpoch(1438574736000);
      var _attendacneDate =
          dateformat.format(DateTime.fromMillisecondsSinceEpoch(dayMap.date!));
      var _attendacneMonth =
          monthformat.format(DateTime.fromMillisecondsSinceEpoch(dayMap.date!));
      dailyReport.add({
        'Date': _attendacneDate,
        'CheckIn':
            _checkInTime.year > 2020 ? timeFromat.format(_checkInTime) : '_',
        'CheckOut':
            _checkOutTime.year > 2020 ? timeFromat.format(_checkOutTime) : '_',
        'Hours':
            ('${dayMap.todayMinutes! ~/ 60} h : ${dayMap.todayMinutes! % 60} min'),
        'month': dayMap.month
      });
      print(dayMap.todayMinutes);
      /* --------------------- count total minutes of employee -------------------- */
      _totalminutes = _totalminutes + dayMap.todayMinutes!;

      if (_currentMonth == _attendacneMonth) {
        /* ------------------------ count this month minutes ------------------------ */
        _thisMonthminutes = _thisMonthminutes + dayMap.todayMinutes!;
        /* ------------------------- check earliest minutes ------------------------- */
        if (_checkInTime.hour <= _earliestHour) {
          if (_checkInTime.minute <= _earliestMinutes) {
            _earliestHour = _checkInTime.hour;
            _earliestMinutes = _checkInTime.minute;
          }
        }
        /* -------------------------- check latest checkout ------------------------- */
        if (dayMap.checkOut != null) {
          if (_checkOutTime.hour >= _latestHour) {
            if (_checkOutTime.minute >= _latestHour) {
              _latestHour = _checkOutTime.hour;
              _latestMinutes = _checkOutTime.minute;
            }
          }
        }
        /* --------------------- check average check in of month -------------------- */
        if (_checkInTime.hour != 0) {
          _avgCheckInMinute.add((_checkInTime.hour * 60) + _checkInTime.minute);
        }
        /* -------------------- check average check out of month -------------------- */
        if (_checkOutTime.year > 2020 && _checkOutTime.hour != 0) {
          _avgCheckOutMinute
              .add((_checkOutTime.hour * 60) + _checkOutTime.minute);
        }
        /* --------------------------- check today minutes -------------------------- */
        if (_todayDate == _attendacneDate) {
          if (dayMap.checkOut != 0 &&
              dayMap.checkOut != null &&
              dayMap.checkIn != null &&
              dayMap.checkIn != 0) {
            _todayminutes = (_checkOutTime.difference(_checkInTime)).inMinutes;
          } else {
            var nowstamp = DateTime.now().millisecondsSinceEpoch;
            if (dayMap.checkIn != 0 && dayMap.checkIn != null)
              _todayminutes =
                  (DateTime.now().difference(_checkInTime)).inMinutes;
          }
        }
      }
    });
    /* --------------------- String for average check in --------------------- */
    int total = 0;
    _avgCheckInMinute.forEach((minute) {
      total = total + minute;
    });
    /* ---------------------- String for average check out ---------------------- */
    var avgin = minutesToTime(
        total ~/ _avgCheckInMinute.length == 0 ? 1 : _avgCheckInMinute.length);
    total = 0;
    _avgCheckOutMinute.forEach((minute) {
      total = total + minute;
    });
    var avgout = total != 0 && _avgCheckOutMinute.length != 0
        ? minutesToTime(total ~/ _avgCheckOutMinute.length)
        : '-';
    totalHours = _totalminutes ~/ 60;
    todayHours = _todayminutes ~/ 60;
    todayWorkTime =
        "${todayHours > 0 ? todayHours.toString() + " h :" : ""} ${_todayminutes % 60} min";
    todayAttendance = attendanceMapList
        .where((attendance) => attendance.day == DateTime.now().day)
        .first;
    DateTime newcheckIn =
        DateTime.fromMillisecondsSinceEpoch(todayAttendance.checkIn ?? 0);
    todayCheckIn =
        '${todayAttendance.checkIn != null ? timeFromat.format(newcheckIn) : '-'}';
    DateTime newcheckOut =
        DateTime.fromMillisecondsSinceEpoch(todayAttendance.checkOut ?? 0);

    todayCheckOut =
        '${todayAttendance.checkOut != null && todayAttendance.checkOut! > 0 ? timeFromat.format(newcheckOut) : '-'}';
    thisMonthHours = _thisMonthminutes ~/ 60;
    earliestCheckIn = _earliestHour == 25 && _earliestMinutes == 100
        ? '_'
        : minutesToTime(_earliestHour * 60 + _earliestMinutes);

    latestCheckOut = _latestHour == 0 && _latestMinutes == 0
        ? '_'
        : minutesToTime(_latestHour * 60 + _latestMinutes);

    averageCheckIn = avgin;
    averageCheckOut = avgout;

    // print(dailyReport);

    update();
  }

  minutesToTime(minutes) {
    int hours = minutes ~/ 60;
    String isAm = ' AM';
    if (hours % 11 == 1) {
      isAm = ' PM';
    }
    hours = hours <= 12
        ? hours == 0
            ? 12
            : hours
        : hours - 12;
    int _minuteInt = minutes % 60;
    String stringValue = hours.toString() +
        ':' +
        (_minuteInt > 9 ? _minuteInt.toString() : '0' + _minuteInt.toString()) +
        isAm;
    // print(stringValue);
    return stringValue;
  }

  goToDashBoard() async {
    // userDataModel =
    //     await dbController.getUserData(FirebaseAuth.instance.currentUser!.uid);
    isLoading = false;
    Get.off(() => DashboardScreen());
    update();
  }
  /* -------------------------------------------------------------------------- */
  /*                                getAttendance                               */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                               save attendance                              */
  /* -------------------------------------------------------------------------- */
  bool isLoading = false;
  saveAttendance() async {
    isLoading = true;
    update();
    DateTime currentTime = DateTime.now();
    userDataModel =
        await dbController.getUserData(FirebaseAuth.instance.currentUser!.uid);
    update();
    var monthlyAttendance = await dbController.getCurrentMonthAttendance(
        currentTime, userDataModel.id ?? '');
    if (monthlyAttendance.exists) {
      /* --------------------- already monthly document exist --------------------- */
      List<AttendanceModel> _attendanceModelList = [];
      List attendanceMapList = monthlyAttendance['Attendance'];
      attendanceMapList.forEach((dayAttendance) {
        // print(dayAttendance);
        _attendanceModelList.add(AttendanceModel.fromMap(dayAttendance));
      });
      /* ------------------- check today a ttendance Marked or not---------------------------- */
      var index = _attendanceModelList.indexWhere((element) {
        return element.day == currentTime.day;
      });
      /* --------------------------- already checked in --------------------------- */
      if (index != -1) {
        //check is checked in before 1 hour
        if (_attendanceModelList[index].checkIn != null &&
            _attendanceModelList[index].checkIn! > 0) {
          int difference = currentTime
              .difference(DateTime.fromMillisecondsSinceEpoch(
                  _attendanceModelList[index].checkIn ?? 0))
              .inHours;
          /* ----------------------- is check in before one hour ---------------------- */
          if (difference > 0) {
            if (_attendanceModelList[index].checkOut == null &&
                _attendanceModelList[index].checkIn != null) {
              int todayMinutes = currentTime
                  .difference(DateTime.fromMillisecondsSinceEpoch(
                      _attendanceModelList[index].checkIn ?? 0))
                  .inMinutes;
              _attendanceModelList[index].checkOut =
                  currentTime.millisecondsSinceEpoch;
              _attendanceModelList[index].todayMinutes = todayMinutes;
              List attendanceMapList = [];
              _attendanceModelList.forEach((element) {
                attendanceMapList.add(element.toMap());
              });
              await dbController.saveAttendance(
                  currentTime, attendanceMapList, userDataModel.id ?? '');
              countHours();

              // attendanceCollection
              //     .doc(
              //         '${currentTime.month}${userDataModel.id}${currentTime.year}')
              //     .set({'Attendance': attendanceMapList});
              isLoading = false;
              notificationController.sendNotification(
                  '${userDataModel.name} Checked Out', 'Checked Out');
              Get.off(() => DashboardScreen());

              Get.snackbar('Checked out', 'You Checked out Successfully',
                  backgroundColor: Colors.green.withOpacity(0.5));
            } else {
              isLoading = false;
              Get.off(() => ErrorScreen());

              Get.snackbar('Error', 'You already checked out',
                  backgroundColor: Colors.red.withOpacity(0.5),
                  colorText: Colors.white);
            }
          } else {
            // print('Please Wait 1 hour to check out');
            isLoading = false;

            Get.snackbar('Error', 'Please wait for one hour to check out',
                backgroundColor: Colors.red.withOpacity(0.5),
                colorText: Colors.white);
          }
        } else {
          int todayMinutes = 0;
          _attendanceModelList[index].checkIn =
              currentTime.millisecondsSinceEpoch;
          _attendanceModelList[index].todayMinutes = todayMinutes;
          List attendanceMapList = [];
          _attendanceModelList.forEach((element) {
            attendanceMapList.add(element.toMap());
          });
          await dbController.saveAttendance(
              currentTime, attendanceMapList, userDataModel.id ?? '');
          countHours();

          // attendanceCollection
          //     .doc(
          //         '${currentTime.month}${userDataModel.id}${currentTime.year}')
          //     .set({'Attendance': attendanceMapList});
          isLoading = false;
          notificationController.sendNotification(
              '${userDataModel.name} Checked In', 'Checked In');
          Get.off(() => DashboardScreen());

          Get.snackbar('Checked In', 'You Checked In Successfully',
              backgroundColor: Colors.green.withOpacity(0.5));
        }
      } else {
/* ---------------------- check in first time in a day ---------------------- */
        AttendanceModel newAttendance = AttendanceModel(
          checkIn: currentTime.millisecondsSinceEpoch,
          date: currentTime.millisecondsSinceEpoch,
          day: currentTime.day,
          month: DateFormat('MMM').format(currentTime),
          id: userDataModel.id,
          name: userDataModel.name,
        );
        _attendanceModelList.add(newAttendance);
        List attendanceMapList = [];
        _attendanceModelList.forEach((element) {
          attendanceMapList.add(element.toMap());
        });
        await dbController.saveAttendance(
            currentTime, attendanceMapList, userDataModel.id ?? '');
        countHours();
        isLoading = false;
        messaging.sendMessage();
        notificationController.sendNotification(
            '${userDataModel.name} Checked In', 'Checked In');
        Get.off(() => DashboardScreen());

        // attendanceCollection
        //     .doc('${currentTime.month}${userDataModel.id}${currentTime.year}')
        //     .set({'Attendance': attendanceMapList});

        Get.snackbar('Checked In', 'You Checked in Successfully',
            backgroundColor: Colors.green.withOpacity(0.5));
      }
    } else {
      /* --------------------------- new month attendance  -------------------------- */
      AttendanceModel newAttendance = AttendanceModel(
        checkIn: currentTime.millisecondsSinceEpoch,
        date: currentTime.millisecondsSinceEpoch,
        day: currentTime.day,
        month: DateFormat('MMM').format(currentTime),
        id: userDataModel.id,
        name: userDataModel.name,
      );
      List attendanceMapList = [newAttendance.toMap()];
      dbController.saveAttendance(
          currentTime, attendanceMapList, userDataModel.id ?? '');

      countHours();
      isLoading = false;
      notificationController.sendNotification(
          '${userDataModel.name} Checked In', 'Checked In');
      Get.off(() => DashboardScreen());

      // attendanceCollection
      //     .doc('${currentTime.month}${userDataModel.id}${currentTime.year}')
      //     .set({'Attendance': attendanceMapList});

      Get.snackbar('Checked In', 'You Checked in Successfully',
          backgroundColor: Colors.green.withOpacity(0.5));
    }
  }

  clear() {
    lat = 0;
    long = 0;

    dataFetched = false;
    dbController = Get.put(DbController());
    attendanceMapList = [];
    dailyReport = [];
/* -------------------------------------------------------------------------- */
    todayHours = 0;
    totalHours = 0;
    thisMonthHours = 0;
    averageCheckIn = '';
    averageCheckOut = '';
    earliestCheckIn = '';
    latestCheckOut = '';
    todayWorkTime = '';
    var timeFormat = DateFormat("j:m");
  }

  /* -------------------------------------------------------------------------- */
  /*                   checkIn and check out bar code scanner                   */
  /* -------------------------------------------------------------------------- */
  QRViewController? qrController;
  Barcode? result;
  bool qrError = false;
  bool codeScaned = false;
  final GlobalKey qrAttendanceKey = GlobalKey(debugLabel: 'QRAttendance');

  void onQRViewCreated(QRViewController qrController) {
    this.qrController = qrController;

    qrController.scannedDataStream.listen((scanData) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        result = scanData;
        String? data = result!.code;
        qrController.pauseCamera();
        // print(data);

        if (data == '$code') {
          qrError = false;
          Get.off(() => CheckinResult());
        } else {
          qrError = true;
          Get.off(() => CheckinResult());
        }
        codeScaned = true;
        update();
      } else {
        Get.snackbar("No Internet", "Please connect to the internet",
            backgroundColor: Colors.black, colorText: Colors.white);
      }
    });
  }

  qrPause() {
    // super.reassemble();
    if (qrController != null) {
      qrError = false;
      codeScaned = false;

      if (Platform.isAndroid) {
        qrController!.pauseCamera();
        qrController!.resumeCamera();
      } else if (Platform.isIOS) {
        qrController!.resumeCamera();
        // }
      }
    }
    // @override
    // void onClose() {
    //   qrController?.dispose();
    //   // TODO: implement onClose
    //   super.onClose();
    // }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      LocationPermission permission = await Geolocator.requestPermission();
      qrError = true;
      Get.off(() => CheckinResult());
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        qrError = true;
        Get.off(() => CheckinResult());
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      qrError = true;
      Get.off(() => CheckinResult());
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var location = await Geolocator.getCurrentPosition();
    return location;
  }

  checkLocation(lat, long) async {
    var distance = Geolocator.distanceBetween(userPosition!.latitude,
        userPosition!.longitude, lat, long); // update();
    if (distance > 500) {
      qrError = true;
      Get.off(() => CheckinResult());
    } else {
      dataFetched = true;
      qrError = false;

      // qrController!.resumeCamera();

      update();
    }
  }

  void getUserData() async {
    dataFetched = false;
    // update();
    var user = FirebaseAuth.instance.currentUser?.uid;
    userPosition = await _determinePosition();
    userDataModel = await dbController.getUserData(user);
  }
}
