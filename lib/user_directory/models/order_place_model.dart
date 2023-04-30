class OrderPlaceModel {
  final String buyerId;
  final String brandId;
  final DateTime orderDate;
  final String orderStatus;
  final String paymentMethod;
  final String deliveryCharges;
  final String totalAmount;
  final List<Products> products;

  OrderPlaceModel({
    required this.buyerId,
    required this.brandId,
    required this.orderDate,
    required this.orderStatus,
    required this.paymentMethod,
    required this.deliveryCharges,
    required this.totalAmount,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'buyerId': buyerId,
      'brandId': brandId,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'paymentMethod': paymentMethod,
      'deliveryCharges': deliveryCharges,
      'totalAmount': totalAmount,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderPlaceModel.fromMap(Map<String, dynamic> map) {
    return OrderPlaceModel(
      buyerId: map['buyerId'] as String,
      brandId: map['brandId'] as String,
      orderDate: DateTime.parse(map['orderDate']),
      orderStatus: map['orderStatus'] as String,
      paymentMethod: map['paymentMethod'] as String,
      deliveryCharges: map['deliveryCharges'] as String,
      totalAmount: map['totalAmount'] as String,
      products: List<Products>.from(
        (map['products'] as List<int>).map<Products>(
          (x) => Products.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class Products {
  final String brandId;
  final String buyerId;
  final String buyerName;
  final String productId;
  final String productName;
  final String productImage;
  final String productColor;
  final String productPrice;
  final String productSize;
  final String orderQuantity;
  final String totalOrderPrice;

  Products({
    required this.brandId,
    required this.buyerId,
    required this.buyerName,
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
      'buyerId': buyerId,
      'buyerName': buyerName,
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

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      brandId: map['brandId'] ?? '',
      buyerId: map['buyerId'] ?? '',
      buyerName: map['buyerName'] ?? '',
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
