import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  sendNotification(subject, title) async {
//     final postUrl = 'https://fcm.googleapis.com/fcm/send';

//     String toParams = "techorra";

//     final data = {
//       "notification": {"body": subject, "title": title},
//       "priority": "high",
//       "data": {
//         "click_action": "FLUTTER_NOTIFICATION_CLICK",
//         "id": "1",
//         "status": "done",
//         "sound": 'default',
//         "screen": "techorra",
//       },
//       "to": "/topics/techorra"
//     };

//     final headers = {
//       'content-type': 'application/json',
//       'Authorization':
//           'key=AAAAG-h4HmI:APA91bF3F6tpWFYRmrhflpDl5n6AnHok8Z3oBGSd_FI7oluJc3oEyniz-v0kVh-IA6F-hEJNcRbwY76aBjgHXZWcwr6zEhqhSo00ANFXHNhLRXQ9RTvjDC4AQs5J3tDXrUl-2RLpHcju'
//     };

//     final response = await http.post(Uri.parse(postUrl),
//         body: json.encode(data),
//         encoding: Encoding.getByName('utf-8'),
//         headers: headers);

//     if (response.statusCode == 200) {
// // on success do
//       print("Notificaiton Send");
//       print(response.body);
//     } else {
// // on failure do
//       print("Error");
//     }
//   }
  }
}
