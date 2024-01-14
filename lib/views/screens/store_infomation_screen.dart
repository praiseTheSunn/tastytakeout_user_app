import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../view_models/StoreInfomationScreenViewModel.dart';
import 'chat_detail_screen.dart';

class StoreInfomationScreen extends StatelessWidget {
  const StoreInfomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int storeId = Get.arguments;
    var viewModel = Get.put(StoreInfomationScreenViewModel(storeId: storeId));
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cửa hàng'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (viewModel.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                viewModel.storeInfo.value.imgUrl,
                                height: 120,
                                width: 120,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.error,
                                    size: 120,
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  viewModel.storeInfo.value.name,
                                  style: TextStyle(
                                      fontSize: 26, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  viewModel.storeInfo.value.address,
                                  style: TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  viewModel.storeInfo.value.likers_count
                                          .toString() +
                                      ' lượt thích',
                                  style: TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Yêu thích',
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(width: 8.0),
                                Icon(Icons.favorite_border),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          InkWell(
                            onTap: () {
                              Get.to(() => ChatDetailScreen(),
                                  arguments: {
                                    'chat_room_id': 10.toString() + '_' + storeId.toString(),
                                    'store_id': storeId,
                                    'store_name': viewModel.storeInfo.value.name,
                                    'store_image_url': viewModel.storeInfo.value.imgUrl,
                                    'buyer_image_url': viewModel.storeInfo.value.imgUrl,
                                  });
                            } ,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Chat', style: TextStyle(fontSize: 16)),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.chat_bubble_outline),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Danh Sách Món Ăn',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        // Sử dụng shrinkWrap để ListView không chiếm toàn bộ không gian// Tắt khả năng scroll của ListView
                        itemCount: viewModel.storeInfo.value.foods.length,
                        // Số lượng món ăn, có thể thay đổi tùy theo data của bạn
                        itemBuilder: (context, index) {
                          // Sử dụng data thật của bạn ở đây
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Image.network(
                                    viewModel
                                        .storeInfo.value.foods[index].imgUrl,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        viewModel
                                            .storeInfo.value.foods[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                      ),
                                      Text(
                                        NumberFormat("#,##0", "vi_VN").format(
                                                viewModel.storeInfo.value
                                                    .foods[index].price) +
                                            ' đ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 12,
                                            rating: viewModel.storeInfo.value
                                                .foods[index].rating,
                                          ),
                                          Text(
                                            viewModel.storeInfo.value
                                                .foods[index].rating
                                                .toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
