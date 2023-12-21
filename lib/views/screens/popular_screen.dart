import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:tastytakeout_user_app/viewmodels/popular_screen_viewmodel.dart';
// import 'package:tastytakeout_user_app/views/screens/food_details_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/item_food_extra.dart';
import 'package:tastytakeout_user_app/view_models/PopularScreenViewModel.dart';

class PopularScreen extends StatefulWidget {
  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  late PopularScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PopularScreenViewModel(); // Replace with your viewmodel implementation
    _viewModel.fetchData(); // Fetch data from somewhere
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Phổ biến',
        onMenuPressed: () {
          // Open drawer or perform other actions
        },
        onSearchPressed: () {
          // Perform search function
        },
        onNotificationPressed: () {
          // Perform notification action
        },
        onUserPressed: () {
          // Open user profile or perform other user-related actions
        },
        // Add necessary onPressed callbacks for the app bar icons
      ), // Replace with your custom app bar implementation
      body: ListView.builder(
        itemCount: _viewModel.foodList.length,
        itemBuilder: (context, index) {
          final food = _viewModel.foodList[index];
          return FoodCard(
            foodName: food.name,
            // description: food.description,
            imagePath: food.imageUrl,
            price: food.price.toString(),
            shopName: food.shopName, // Pass shopName to FoodCard
            onTap: () {
              print("Tapped on ${food.name}");
            },
          );
        },
      ),
    );
  }
}

//       body: ListView.builder(
//         itemCount: _viewModel.foodList.length,
//         itemBuilder: (context, index) {
//           final food = _viewModel.foodList[index];
//           return ListTile(
//             title: Text(food.name),
//             subtitle: Text(food.description),
//             onTap: () {
//               print("Tapped on ${food.name}");

//             }
//           );
//         },
//       ),
//     );
//   }
// }
