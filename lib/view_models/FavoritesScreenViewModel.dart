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

class FavoritesScreenViewModel {
  List<Food> foodList = [];

  void fetchData() {
    // Hardcoded data for demonstration purposes
    foodList = [
      Food(
        name: 'Pizza',
        description: 'A delicious pizza topped with a rich tomato sauce, '
            'mozzarella cheese, and a variety of fresh toppings including '
            'pepperoni, bell peppers, and olives.',
        imageUrl: 'lib/resources/food1.jpg',
        price: 9.99,
        shopName: 'Pizza Shop',
      ),
      Food(
        name: 'Burger',
        description: 'This tasty burger is made with a freshly grilled beef patty, '
            'served on a toasted bun with lettuce, tomato, and our special sauce. '
            'Add cheese or bacon to take it to the next level!',
        imageUrl: 'lib/resources/food2.jpg',
        price: 6.99,
        shopName: 'Burger Shop',
      ),
      Food(
        name: 'Pasta',
        description: 'Our yummy pasta features al dente noodles tossed in a '
            'homemade garlic and basil pesto sauce, topped with grated Parmesan '
            'cheese and sun-dried tomatoes.',
        imageUrl: 'lib/resources/food3.jpg',
        price: 12.99,
        shopName: 'Pasta Shop',
      ),
    ];
  }
}