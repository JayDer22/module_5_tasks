class ProductModel {
  int? id;
  String name;
  String category;
  int price;

  ProductModel({
    this.id,
    required this.name,
    required this.category,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "price": price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"],
      name: map["name"],
      category: map["category"],
      price: map["price"],
    );
  }
}