class BrandModel {
  final String uId;
  final String name;
  final String email;
  final String logo;
  final String category;

  BrandModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.logo,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'name': name,
      'email': email,
      'logo': logo,
      'category': category,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      uId: map['uId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      logo: map['logo'] as String,
      category: map['category'] as String,
    );
  }
}
