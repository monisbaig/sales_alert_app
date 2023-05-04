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

  Future<void> getTokenAndSendNotificationToUser(String productName) {
    return brandNotificationRepository.getTokenAndSendNotificationToUser(
      productName: productName,
    );
  }

  Future<void> getTokenAndSendNotificationToUserProduct(
    String productId,
    String productName,
  ) {
    return brandNotificationRepository.getTokenAndSendNotificationToUserProduct(
      productId: productId,
      productName: productName,
    );
  }
}
