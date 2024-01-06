class StoreModel {
  String name;
  String address;
  String imgUrl;
  int id;
  bool isLike;
  int likers_count;
  List<dynamic> foods;

  StoreModel({
    required this.name,
    required this.address,
    required this.imgUrl,
    required this.id,
    required this.isLike,
    required this.likers_count,
    required this.foods,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      name: json['name'],
      address: json['address'],
      imgUrl: json['image_url'],
      id: json['id'],
      isLike: json['is_liked'],
      likers_count: json['likers_count'],
      foods: json['foods'].map((e) => Food.fromJson(e)).toList(),
    );
  }
}

class Food {
  int id;
  String name;
  int price;
  double rating;
  String imgUrl;

  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.imgUrl,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      rating: json['rating'],
      imgUrl: json['image_urls'][0],
    );
  }
}
