class FollowingModel {
  final String brandId;
  final String brandName;
  final bool follow;

  FollowingModel({
    required this.brandId,
    required this.brandName,
    required this.follow,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brandId': brandId,
      'brandName': brandName,
      'follow': follow,
    };
  }

  factory FollowingModel.fromMap(Map<String, dynamic> map) {
    return FollowingModel(
      brandId: map['brandId'] ?? '',
      brandName: map['brandName'] ?? '',
      follow: map['follow'] ?? '',
    );
  }
}
