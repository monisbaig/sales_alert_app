class UserModel {
  final String uId;
  final String name;
  final String email;
  final String fcmToken;
  final String profileImage;
  final String address;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.fcmToken,
    required this.profileImage,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'name': name,
      'email': email,
      'fcmToken': fcmToken,
      'profileImage': profileImage,
      'address': address,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
      profileImage: map['profileImage'] ?? '',
      address: map['address'] ?? '',
    );
  }
}
