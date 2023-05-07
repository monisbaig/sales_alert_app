// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sales_alert_app/common_component/global_variables.dart';

import '../../models/brand_model.dart';
import '../../models/follower_model.dart';

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

  Future<void> getTokenAndSendNotificationToUser(
      {required String productName}) async {
    List<FollowerModel> allUserTokens = [];

    var followerData = await firestore
        .collection('brands')
        .doc(auth.currentUser!.uid)
        .collection('followers')
        .get();

    for (var tokens in followerData.docs) {
      var list = FollowerModel.fromMap(tokens.data());
      allUserTokens.add(list);
    }

    var userToken = allUserTokens.map((e) => e.fcmToken).toList();

    var brandData =
        await firestore.collection('brands').doc(auth.currentUser!.uid).get();

    var brand = BrandModel.fromMap(brandData.data()!);

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var data = {
      'registration_ids': userToken,
      'priority': 'high',
      'notification': {
        'title': '${brand.name} ($productName)',
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

  Future<void> getTokenAndSendNotificationToUserProduct({
    required String productId,
    required String productName,
  }) async {
    List<FollowerModel> allUserTokens = [];

    var followerData = await firestore
        .collection('brands')
        .doc(auth.currentUser!.uid)
        .collection('productFollowers')
        .where('productId', isEqualTo: productId)
        .get();

    for (var tokens in followerData.docs) {
      var list = FollowerModel.fromMap(tokens.data());
      allUserTokens.add(list);
    }

    var userToken = allUserTokens.map((e) => e.fcmToken).toList();

    var brandData =
        await firestore.collection('brands').doc(auth.currentUser!.uid).get();

    var brand = BrandModel.fromMap(brandData.data()!);

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var data = {
      'registration_ids': userToken,
      'priority': 'high',
      'notification': {
        'title': '${brand.name} ($productName)',
        'body': 'Special discount offer!',
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
