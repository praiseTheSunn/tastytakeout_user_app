import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:intl/intl.dart';
import 'package:tastytakeout_user_app/view_models/FoodDetailScreenViewModel.dart';
import 'package:tastytakeout_user_app/views/screens/store_infomation_screen.dart';

class FoodDetailScreen extends StatelessWidget {
  final int foodId;

  FoodDetailScreen({super.key, required this.foodId});

  @override
  Widget build(BuildContext context) {
    final FoodDetailScreenViewModel viewModel =
        Get.put(FoodDetailScreenViewModel(foodId));
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chi tiết sản phẩm"),
      ),
      body: Obx(
        () {
          if (viewModel.isLoading.value) {
            print('Loading...');
            return Center(child: CircularProgressIndicator());
          } else {
            print(viewModel.foodDetail.value.name);
            return SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(0),
                      child: CarouselSlider(
                        items: List.generate(
                            viewModel.foodDetail.value.imageUrl.length,
                            (index) => index).map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                child: Container(
                                  width: 400,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 5.0),
                                  child: Image.network(
                                    viewModel.foodDetail.value.imageUrl[i],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: InteractiveViewer(
                                          panEnabled: false,
                                          boundaryMargin: EdgeInsets.all(20),
                                          minScale: 0.5,
                                          maxScale: 4,
                                          child: Image.network(
                                              viewModel
                                                  .foodDetail.value.imageUrl[i],
                                              fit: BoxFit.cover),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 400,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          aspectRatio: 1.0,
                          autoPlay: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    viewModel.foodDetail.value.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    NumberFormat("#,##0", "vi_VN")
                            .format(viewModel.foodDetail.value.price) +
                        ' đ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: RatingBarIndicator(
                              rating: viewModel.foodDetail.value.rating,
                              itemSize: 20,
                              itemBuilder: (context, _) => Icon(
                                size: 17,
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            viewModel.foodDetail.value.rating.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            child: Container(
                              child: !viewModel.isFavorite.value
                                  ? Icon(Icons.favorite_outline)
                                  : Icon(Icons.favorite),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                            onTap: () {
                              Future<bool> res = viewModel.changeLikeStatus();
                              if (res != null) {
                                res.then((value) {
                                  if (value) {
                                    Get.snackbar(
                                      'Thành công',
                                      viewModel.isFavorite.value
                                          ? 'Đã thêm vào danh sách yêu thích'
                                          : 'Đã xóa khỏi danh sách yêu thích',
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  } else {
                                    Get.snackbar(
                                      'Thất bại',
                                      'Đã xảy ra lỗi',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                });
                              }
                            },
                            radius: 10,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          SizedBox(width: 8.0),
                          InkWell(
                            child: Container(
                              child: Icon(Icons.shopping_cart_outlined),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  int quantity = 1;
                                  return AlertDialog(
                                    title: Text('Thêm sản phẩm vào giỏ hàng'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            'Bạn muốn thêm bao nhiêu sản phẩm vào giỏ hàng?'),
                                        SizedBox(height: 8.0),
                                        InputQty.int(
                                          decoration: QtyDecorationProps(),
                                          initVal: 1,
                                          onQtyChanged: (value) {
                                            quantity = value;
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Hủy'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          var res = viewModel.addFoodToCart(
                                              foodId, quantity);
                                          if (res != null) {
                                            res.then((value) {
                                              if (value) {
                                                Get.snackbar(
                                                  'Thành công',
                                                  'Đã thêm vào giỏ hàng',
                                                  backgroundColor: Colors.green,
                                                  colorText: Colors.white,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                );
                                              } else {
                                                Get.snackbar(
                                                  'Thất bại',
                                                  'Đã xảy ra lỗi',
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                );
                                              }
                                            });
                                          }
                                          Get.back();
                                        },
                                        child: Text('Có'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            radius: 10,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  viewModel
                                      .foodDetail.value.storeDetail.imageUrl,
                                  height: 60,
                                  width: 60,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.error,
                                      size: 60,
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ), // Logo của nhà cung cấp
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      viewModel
                                          .foodDetail.value.storeDetail.name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4.0),
                                  Text(
                                    viewModel
                                        .foodDetail.value.storeDetail.address,
                                    style: TextStyle(fontSize: 16),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Text(
                            'Xem chi tiết',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onTap: () {
                          Get.to(() => StoreInfomationScreen(),
                              arguments:
                                  viewModel.foodDetail.value.storeDetail.id);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'Mô tả sản phẩm',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(viewModel.foodDetail.value.description),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
