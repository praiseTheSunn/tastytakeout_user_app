import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';

class FoodSource {
  // final String apiUrl = 'http://localhost:8000/foods/';
  // final baseUrl = Uri.http('localhost:8000', '/foods/');

  final baseUrl = Uri.http('192.168.13.101:8000', '/foods/');

  // Future<void> fetchData() async {
  //   try {
  //     final response = await http.get(
  //       baseUrl
  //       // headers: {
  //       //   'accept': 'application/json',
  //       //   'X-CSRFToken': 'n5Lm8twiNK1239FTN1RwuCGcVFzHIdHW6iVxVnFeMYk5TWdVVhR7nRKyl66L2Q47',
  //       // },
  //     );

  //     if (response.statusCode == 200) {
  //       // Successful GET request
  //       print('Response: ${response.body}');

  //       var jsonString = response.body;

  //       // Parse the JSON string
  //       List<dynamic> jsonData = json.decode(jsonString);

  //       // Extract information
  //       if (jsonData.isNotEmpty) {
  //         Map<String, dynamic> foodItem = jsonData[0];

  //         int id = foodItem['id'];
  //         String categoryName = foodItem['category']['name'];
  //         String storeName = foodItem['store']['name'];
  //         double rating = foodItem['rating'];
  //         // Add more fields as needed

  //         // Print extracted information
  //         print('ID: $id');
  //         print('Category Name: $categoryName');
  //         print('Store Name: $storeName');
  //         print('Rating: $rating');
  //         // Print more fields as needed
  //       }


  //     } else {
  //       // Error handling for unsuccessful requests
  //       print('Request failed with status: ${response.statusCode}');
  //     }

  //   } catch (e) {
  //     // Exception handling
  //     print('Exception during request: $e');
  //   }
  // }

  Future<Iterable> getPopularFoodImages(double rating) async {
    try {
      final uri = Uri.parse('$baseUrl?order=&rating__gt=$rating');
      // final response = await http.get(uri);
      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          // 'X-CSRFToken': 'n5Lm8twiNK1239FTN1RwuCGcVFzHIdHW6iVxVnFeMYk5TWdVVhR7nRKyl66L2Q47',
        },
      );

      if (response.statusCode == 200) {
        var jsonString = response.body;
        List<dynamic> jsonData = json.decode(jsonString);

        // Extract image URLs
        Iterable imageUrls = jsonData
            .map((foodItem) =>
                foodItem['image_urls'] != null ? foodItem['image_urls'][0] : null)
            .where((imageUrl) => imageUrl != null)
            ;
        
        return imageUrls;
      } else {
        // Error handling for unsuccessful requests
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Exception handling
      print('Exception during request: $e');
      return [];
    }
  }

    Future<Iterable> getFoodWithRating(double rating) async {
    try {
      final uri = Uri.parse('$baseUrl?order=&rating__gt=$rating');
      // final response = await http.get(uri);
      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          // 'X-CSRFToken': 'n5Lm8twiNK1239FTN1RwuCGcVFzHIdHW6iVxVnFeMYk5TWdVVhR7nRKyl66L2Q47',
        },
      );

      if (response.statusCode == 200) {
        var jsonString = utf8.decode(response.bodyBytes);
        List<dynamic> jsonData = json.decode(jsonString);

        Iterable foods = jsonData
            .map((foodItem) =>
                FoodModel.fromJson(foodItem))
            // .where((food) => food)
            ;
        
        return foods;
      } else {
        // Error handling for unsuccessful requests
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Exception handling
      print('Exception during request: $e');
      return [];
    }
  }

  Future<Iterable> getFavoriteFood() async {
    try {
      final uri = Uri.parse('$baseUrl?is_liked=true');
      // final response = await http.get(uri);
      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          // 'X-CSRFToken': 'n5Lm8twiNK1239FTN1RwuCGcVFzHIdHW6iVxVnFeMYk5TWdVVhR7nRKyl66L2Q47',
        },
      );

      if (response.statusCode == 200) {
        var jsonString = utf8.decode(response.bodyBytes);
        List<dynamic> jsonData = json.decode(jsonString);

        Iterable foods = jsonData
            .map((foodItem) =>
                FoodModel.fromJson(foodItem))
            // .where((food) => food)
            ;
        
        return foods;
      } else {
        // Error handling for unsuccessful requests
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Exception handling
      print('Exception during request: $e');
      return [];
    }
  }

  Future<Iterable> getFoodWithName(String queryString) async {
    try {
      final uri = Uri.parse('$baseUrl?name=$queryString');
      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          // 'X-CSRFToken': 'n5Lm8twiNK1239FTN1RwuCGcVFzHIdHW6iVxVnFeMYk5TWdVVhR7nRKyl66L2Q47',
        },
      );

      if (response.statusCode == 200) {
        // var jsonString = response.body;
        var jsonString = utf8.decode(response.bodyBytes);
        List<dynamic> jsonData = json.decode(jsonString);

        Iterable foods = jsonData
            .map((foodItem) =>
                FoodModel.fromJson(foodItem))
            // .where((food) => food)
            ;
        
        return foods;
      } else {
        // Error handling for unsuccessful requests
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Exception handling
      print('Exception during request: $e');
      return [];
    }
  }
}