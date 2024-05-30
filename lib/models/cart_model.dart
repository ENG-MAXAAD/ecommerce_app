class Cart {
  String name, category, image;
  int price, quantity, total, originalPrice, productID;

  Cart(
      {required this.name,
      required this.productID,
      required this.category,
      required this.image,
      required this.price,
      this.quantity = 1,
      this.total = 0,
      this.originalPrice = 0});

  factory Cart.fromJson(Map<String, dynamic> data) {
    return Cart(
        productID: data['productID'] ?? 1,
        name: data['name'] ?? "",
        category: data['cat'] ?? "",
        image: data['image'] ?? "",
        price: data['price'] ?? 0,
        originalPrice: data['originalPrice'] ?? 0,
        quantity: data['quantity'] ?? 1,
        total: data['total'] ?? 0);
  }
  Map<String, dynamic> toJson() {
    return {
      "productID": productID,
      "name": name,
      "category": category,
      "image": image,
      "price": price,
      "originalPrice": originalPrice,
      "quantity": quantity,
      "total": total
    };
  }
}
