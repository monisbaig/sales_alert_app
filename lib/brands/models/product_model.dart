class ProductModel {
  final String productId;
  final String brandId;
  final String mainCategory;
  final String category;
  final String name;
  final String price;
  final String discountPrice;
  final String photo;
  final String color;
  final String quantity;
  final String description;
  final String size;

  ProductModel({
    required this.productId,
    required this.brandId,
    required this.mainCategory,
    required this.category,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.photo,
    required this.color,
    required this.quantity,
    required this.description,
    required this.size,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'brandId': brandId,
      'mainCategory': mainCategory,
      'category': category,
      'name': name,
      'price': price,
      'discountPrice': discountPrice,
      'photo': photo,
      'color': color,
      'quantity': quantity,
      'description': description,
      'size': size,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? '',
      brandId: map['brandId'] ?? '',
      mainCategory: map['mainCategory'] ?? '',
      category: map['category'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      discountPrice: map['discountPrice'] ?? '',
      photo: map['photo'] ?? '',
      color: map['color'] ?? '',
      quantity: map['quantity'] ?? '',
      description: map['description'] ?? '',
      size: map['size'] ?? '',
    );
  }
}
