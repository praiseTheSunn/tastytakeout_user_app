class Food {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String shopName; // Added shopName field

  Food({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.shopName, // Added shopName parameter
  });
}

// import 'package:tastytakeout_user_app/models/food.dart';

class PopularScreenViewModel {
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
      ),
      Food(
        name: 'Burger',
        description: 'Tasty burger',
        imageUrl: 'lib/resources/food2.jpg',
        price: 6.99,
        shopName: 'Burger Shop', // Added shopName value
      ),
      Food(
        name: 'Pasta',
        description: 'Yummy pasta',
        imageUrl: 'lib/resources/food3.jpg',
        price: 12.99,
        shopName: 'Pasta Shop', // Added shopName value
      ),
    ];
  }
}