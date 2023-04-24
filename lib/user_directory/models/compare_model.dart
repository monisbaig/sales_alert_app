class CompareModel {
  final String productName;
  final String productImage;
  final String productPrice;
  final String productColor;
  final String productSize;

  CompareModel({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productColor,
    required this.productSize,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'productColor': productColor,
      'productSize': productSize,
    };
  }

  factory CompareModel.fromMap(Map<String, dynamic> map) {
    return CompareModel(
      productName: map['productName'] ?? '',
      productImage: map['productImage'] ?? '',
      productPrice: map['productPrice'] ?? '',
      productColor: map['productColor'] ?? '',
      productSize: map['productSize'] ?? '',
    );
  }
}
