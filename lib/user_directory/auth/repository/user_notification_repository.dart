// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_alert_app/user_directory/screens/bottom_navigator.dart';

final userNotificationRepositoryProvider = Provider((ref) {
  return UserNotificationRepository(
    firestore: FirebaseFirestore.instance,
    messaging: FirebaseMessaging.instance,
    plugin: FlutterLocalNotificationsPlugin(),
  );
});

class UserNotificationRepository {
  final FirebaseFirestore firestore;
  final FirebaseMessaging messaging;
  final FlutterLocalNotificationsPlugin plugin;

  UserNotificationRepository({
    required this.firestore,
    required this.messaging,
    required this.plugin,
  });

  Future<void> initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(1000).toString(),
      'High Importance Notification',
      importance: Importance.max,
      showBadge: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      plugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
      print(message.notification!.title);
    });
  }

  Future<void> firebaseMessagingInit({required BuildContext context}) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> requestNotificationPermission() async {
    final NotificationSettings settings;
    settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('Permission Granted');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('Provisional Permission Granted');
      }
    } else {
      AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('Permission Denied');
      }
    }
  }

  Future<void> setupInteractMessage({required BuildContext context}) async {
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleMessage(context, message);
    });
  }

  Future<void> handleMessage(
      BuildContext context, RemoteMessage message) async {
    if (message.data['type'] == 'msg') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BottomNavigator(),
        ),
      );
    }
  }

  Future<void> getDeviceToken({required String uId}) async {
    var token = await messaging.getToken();
    await firestore.collection('users').doc(uId).update({
      'fcmToken': token,
    });
  }
}
