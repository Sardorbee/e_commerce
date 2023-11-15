class CartModel {
  int id;
  int userId;
  DateTime date;
  List<ProductEntry> products;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((product) => ProductEntry.fromJson(product))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  CartModel copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<ProductEntry>? products,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      products: products ?? this.products,
    );
  }
}

class ProductEntry {
  int productId;
  int quantity;

  ProductEntry({
    required this.productId,
    required this.quantity,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) {
    return ProductEntry(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  ProductEntry copyWith({
    int? productId,
    int? quantity,
  }) {
    return ProductEntry(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }
}
