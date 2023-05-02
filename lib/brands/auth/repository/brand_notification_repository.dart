// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sales_alert_app/common_component/global_variables.dart';
import 'package:sales_alert_app/user_directory/models/user_model.dart';

final brandNotificationRepositoryProvider = Provider((ref) {
  return BrandNotificationRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class BrandNotificationRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  BrandNotificationRepository({
    required this.auth,
    required this.firestore,
  });

  Future<void> getTokenAndSendNotificationToUser() async {
    List<UserModel> allUserTokens = [];

    var userData = await firestore.collection('users').get();
    for (var tokens in userData.docs) {
      var list = UserModel.fromMap(tokens.data());
      allUserTokens.add(list);
    }
    List<String> userUid = allUserTokens.map((e) => e.uId).toList();
    List<String> userToken = allUserTokens.map((e) => e.fcmToken).toList();

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var data = {
      'registration_ids': userToken,
      'priority': 'high',
      'notification': {
        'title': 'Stock Alert',
        'body': 'New stock added go check it out!',
      },
      'data': {
        'id': '1',
        'type': 'msg',
      }
    };
    await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=$serverKey',
      },
    );
  }
}
