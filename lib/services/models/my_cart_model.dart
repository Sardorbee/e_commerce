class MyCartModelFields {
  static const String orderCartTable = "orderCartTable";
  static const String id = "id";
  static const String createdAt = "createdAt";
  static const String quantity = "quantity";
  static const String price = "price";
  static const String originalPrice = "originalPrice";
  static const String orderName = "orderName";
}

class MyCartModel {
  final int? id;
  final String createdAt;
  final String price;
  final String quantity;
  final String orderName;
  final String originalPrice;

  MyCartModel({
    this.id,
    required this.createdAt,
    required this.price,
    required this.quantity,
    required this.orderName,
    required this.originalPrice,
  });

  MyCartModel copyWith({
    int? id,
    String? createdAt,
    String? price,
    String? quantity,
    String? originalPrice,
    String? orderName,
  }) {
    return MyCartModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      originalPrice: originalPrice ?? this.originalPrice,
      orderName: orderName ?? this.orderName,
    );
  }

  factory MyCartModel.fromJson(Map<String, dynamic> json) {
    return MyCartModel(
      id: json['id'],
      createdAt: json['createdAt'],
      price: json['price'],
      quantity: json['quantity'],
      orderName: json['orderName'],
      originalPrice: json['originalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'price': price,
      'quantity': quantity,
      'orderName': orderName,
      'originalPrice': originalPrice,
    };
  }
}
