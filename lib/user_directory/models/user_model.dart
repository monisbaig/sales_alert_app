class UserModel {
  final String uId;
  final String name;
  final String email;
  final String profileImage;
  final String address;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'address': address,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profileImage'] ??
          'https://pbs.twimg.com/profile_images/923557898218889216/g4BH7Arj.jpg',
      address: map['address'] ?? '',
    );
  }
}
