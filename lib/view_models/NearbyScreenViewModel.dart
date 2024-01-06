class Food {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String shopName;
  final String distance;

  Food({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.shopName,
    required this.distance,
  });
}

// import 'package:tastytakeout_user_app/models/food.dart';

class NearbyScreenViewModel {
  List<Food> foodList = [];

  void fetchData() {
    // Hardcoded data for demonstration purposes
    foodList = [
      Food(
        name: 'Pizza',
        description: 'Delicious pizza',
        imageUrl: 'lib/resources/food1.jpg',
        price: 9.99,
        shopName: 'Pizza Shop', // Added shopName value
        distance: '1.2km',
      ),
      Food(
        name: 'Burger',
        description: 'Tasty burger',
        imageUrl: 'lib/resources/food2.jpg',
        price: 6.99,
        shopName: 'Burger Shop', // Added shopName value
        distance: '1.2km',
      ),
      Food(
        name: 'Pasta',
        description: 'Yummy pasta',
        imageUrl: 'lib/resources/food3.jpg',
        price: 12.99,
        shopName: 'Pasta Shop', // Added shopName value
        distance: '1.2km',
      ),
    ];
  }
}
