class FoodModel {
  late final String name;
  late final int price;
  late int quantity;
  late final String imageUrl;
  final String description;
  final String shopName;

  FoodModel({
    this.name = '',
    this.price = 0,
    this.quantity = 0,
    this.imageUrl = '',
    this.description = '',
    this.shopName = '',
  });

  void setQuantity(int setQuantity) {
    this.quantity = setQuantity;
  }

  int getQuantity() {
    return quantity;
  }

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_urls'] != null && json['image_urls'].isNotEmpty
          ? json['image_urls'][0]
          : '',
      price: int.parse((json['price'].toString())),
      shopName: json['store']['name'],
    );
  }
}
