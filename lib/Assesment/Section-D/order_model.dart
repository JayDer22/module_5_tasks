class OrderModel {
  int? id;
  String productName;
  int quantity;

  OrderModel({
    this.id,
    required this.productName,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "product_name": productName,
      "quantity": quantity,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map["id"],
      productName: map["product_name"],
      quantity: map["quantity"],
    );
  }
}