import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:taswel/controllers/userController.dart';
import 'package:taswel/models/user.dart';

class CloudMessageProvider {
  final BuildContext context;
  final UserModel user;

  final FirebaseMessaging _fcm = FirebaseMessaging();

  // ignore: cancel_subscriptions
  StreamSubscription iosSubscription;

  CloudMessageProvider({this.context, this.user});
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  setupNotification() {
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        _saveDeviceToken();
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }
    if (Platform.isAndroid)
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage');
          _showNotification(context: context, message: message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          _showNotification(context: context, message: message);
          print('onLaunch');
        },
        onResume: (Map<String, dynamic> message) async {
          _showNotification(context: context, message: message);
          print('onResume');
        },
      );
  }

  _showNotification({BuildContext context, Map<String, dynamic> message}) {
    print(message['notification']['title']);
    print(message['notification']['body']);
    showDialog(
      context: context,
      builder: (_) => NetworkGiffyDialog(
        image: Image.network(message['data']['image']),
        title: Text(message['data']['title'],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
        description: Text(
          message['data']['title'],
          textAlign: TextAlign.center,
        ),
        onlyOkButton: true,
        buttonOkText: Text(
          'تم',
          style: TextStyle(color: Colors.white),
        ),
        onOkButtonPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _saveDeviceToken() async {
    // String uid = 'users';

    String fcmToken = await _fcm.getToken();
    print(fcmToken);

    if (fcmToken != null) {
      var tokens = _db.collection('cloudmessages').doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem,
        'userName': user.name,
        'userPhone': user.phoneNumber,
        'userEmail': user.email
      });
    }
  }
}
