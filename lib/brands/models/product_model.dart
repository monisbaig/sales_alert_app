class ProductModel {
  final String mainCategory;
  final SubCategoryDetail subCategoryDetail;

  ProductModel({
    required this.mainCategory,
    required this.subCategoryDetail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mainCategory': mainCategory,
      'subCategoryDetail': subCategoryDetail.toMap(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      mainCategory: map['mainCategory'] as String,
      subCategoryDetail: SubCategoryDetail.fromMap(
          map['subCategoryDetail'] as Map<String, dynamic>),
    );
  }
}

class SubCategoryDetail {
  final String productId;
  final String brandId;
  final String category;
  final String name;
  final String price;
  final String photo;
  final String color;
  final String quantity;
  final String description;
  final String size;

  SubCategoryDetail({
    required this.productId,
    required this.brandId,
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

  factory SubCategoryDetail.fromMap(Map<String, dynamic> map) {
    return SubCategoryDetail(
      productId: map['productId'] as String,
      brandId: map['brandId'] as String,
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
