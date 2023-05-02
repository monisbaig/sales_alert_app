import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/brand_notification_repository.dart';

final brandNotificationControllerProvider = Provider((ref) {
  return BrandNotificationController(
    brandNotificationRepository: ref.watch(brandNotificationRepositoryProvider),
  );
});

class BrandNotificationController {
  final BrandNotificationRepository brandNotificationRepository;

  BrandNotificationController({required this.brandNotificationRepository});

  Future<void> getTokenAndSendNotificationToUser() {
    return brandNotificationRepository.getTokenAndSendNotificationToUser();
  }
}
