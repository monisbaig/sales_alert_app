class FollowerModel {
  final String userId;
  final String username;
  final String fcmToken;
  final bool follow;

  FollowerModel({
    required this.userId,
    required this.username,
    required this.fcmToken,
    required this.follow,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'fcmToken': fcmToken,
      'follow': follow,
    };
  }

  factory FollowerModel.fromMap(Map<String, dynamic> map) {
    return FollowerModel(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
      follow: map['follow'] ?? '',
    );
  }
}
