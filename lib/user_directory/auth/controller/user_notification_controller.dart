import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_alert_app/user_directory/auth/repository/user_notification_repository.dart';

final userNotificationControllerProvider = Provider((ref) {
  return UserNotificationController(
    userNotificationRepository: ref.watch(userNotificationRepositoryProvider),
  );
});

class UserNotificationController {
  final UserNotificationRepository userNotificationRepository;

  UserNotificationController({required this.userNotificationRepository});

  Future<void> firebaseMessagingInit(BuildContext context) {
    return userNotificationRepository.firebaseMessagingInit(context: context);
  }

  Future<void> setupInteractMessage(BuildContext context) {
    return userNotificationRepository.setupInteractMessage(context: context);
  }

  Future<void> requestNotificationPermission() {
    return userNotificationRepository.requestNotificationPermission();
  }
}
