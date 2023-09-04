class Product {
  String id;
  String name;
  String description;
  double price;
  int quantity;
  String category;
  bool isPromo;
  double commission;
  String photo;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.quantity = 0,
    required this.category,
    this.isPromo = false,
    this.commission = 0.0,
    this.photo = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity'] ?? 0,
      category: json['category'],
      isPromo: json['isPromo'] ?? false,
      commission: json['commission']?.toDouble() ?? 0.0,
      photo: json['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['quantity'] = quantity;
    data['category'] = category;
    data['isPromo'] = isPromo;
    data['commission'] = commission;
    data['photo'] = photo;

    return data;
  }
}
