class CartModel {
  final String brandId;
  final String brandName;
  final String buyerId;
  final String productId;
  final String productName;
  final String productImage;
  final String productPrice;
  final String productColor;
  final String productSize;
  final String orderQuantity;
  final String totalOrderPrice;

  CartModel({
    required this.brandId,
    required this.brandName,
    required this.buyerId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productColor,
    required this.productSize,
    required this.orderQuantity,
    required this.totalOrderPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brandId': brandId,
      'brandName': brandName,
      'buyerId': buyerId,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'productColor': productColor,
      'productSize': productSize,
      'orderQuantity': orderQuantity,
      'totalOrderPrice': totalOrderPrice,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      brandId: map['brandId'] ?? '',
      brandName: map['brandName'] ?? '',
      buyerId: map['buyerId'] ?? '',
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      productImage: map['productImage'] ?? '',
      productPrice: map['productPrice'] ?? '',
      productColor: map['productColor'] ?? '',
      productSize: map['productSize'] ?? '',
      orderQuantity: map['orderQuantity'] ?? '',
      totalOrderPrice: map['totalOrderPrice'] ?? '',
    );
  }
}
