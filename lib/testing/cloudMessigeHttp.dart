import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taswel/controllers/orderController.dart';
import 'package:http/http.dart' as http;

class CloudMessigeHttp {
  OrderController status = Get.put(OrderController());
  final String serverToken =
      'AAAAPDSzLJM:APA91bExeBZud1C8t_gmx7BJuhlPHkHVQIeyeMaP92zwHUGyBF8j_ZsccARL8fSf0GyMUhC6cE5IcPuzDMUnse8Yah60xh-SiziNsWUK4OsuhE2EG1FbYdoWZbFvbcej7GDQD008uZgI';

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage(
      {String title, String orderNr, List<String> token}) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    token.forEach((element) async {
      await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': '$title - $orderNr',
              'title': orderNr,
              'image':
                  'https://media-exp1.licdn.com/dms/image/C4E0BAQGZONyieGHmLQ/company-logo_200_200/0/1519889426068?e=2159024400&v=beta&t=9GXbkAuei2O--cFq2lsAfq6FGUaH4o9qdu0oqW3GJ-8'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'title': title + orderNr,
              'body': orderNr,
              'image':
                  'https://media-exp1.licdn.com/dms/image/C4E0BAQGZONyieGHmLQ/company-logo_200_200/0/1519889426068?e=2159024400&v=beta&t=9GXbkAuei2O--cFq2lsAfq6FGUaH4o9qdu0oqW3GJ-8'
            },
            'to': element
          },
        ),
      );
    });

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }
}
