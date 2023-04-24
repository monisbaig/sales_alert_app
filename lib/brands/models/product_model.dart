class ProductModel {
  final String productId;
  final String brandId;
  final String mainCategory;
  final String category;
  final String name;
  final String price;
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
      'photo': photo,
      'color': color,
      'quantity': quantity,
      'description': description,
      'size': size,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] as String,
      brandId: map['brandId'] as String,
      mainCategory: map['mainCategory'] as String,
      category: map['category'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
      photo: map['photo'] as String,
      color: map['color'] as String,
      quantity: map['quantity'] as String,
      description: map['description'] as String,
      size: map['size'] as String,
    );
  }
}
