import 'package:flutter/material.dart';
import 'package:tastytakeout_user_app/models/dto/OrderModel.dart';
import 'package:tastytakeout_user_app/views/widgets/item_food.dart';
import 'package:tastytakeout_user_app/utils/format_helper.dart' as formatHelper;

class OrderItemWidget extends StatelessWidget {
  final OrderModel order;

  OrderItemWidget({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${order.storeName} - ${formatHelper.formatMoney(order.cost)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.foods.length,
              itemBuilder: (context, index) {
                return FoodItemView(
                  topText: order.foods[index].name,
                  quantity: order.foods[index].quantity,
                  bottomText: formatHelper.formatMoney(order.foods[index].cost),
                  imageUrl: order.foods[index].imageUrl,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
