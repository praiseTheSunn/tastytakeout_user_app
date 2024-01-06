import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/views/widgets/cart_item.dart';
import 'package:tastytakeout_user_app/views/widgets/order_item.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/cart_confirm_bottom_sheet.dart';

class CartController extends GetxController {
  final title = 'Cart'.obs;
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListOrdersViewModel());
    Get.lazyPut(() => CartController());
  }
}

class _CartPageState extends State<CartPage> {
  final _listCartViewModel = Get.find<ListOrdersViewModel>();
  final _cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    _listCartViewModel.fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cart",
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (_listCartViewModel.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(20, 0.0, 20, 20),
                    itemCount: _listCartViewModel.cartList.length,
                    itemBuilder: (context, cartIndex) {
                      return CartItemWidget(
                          cartIndex: cartIndex, clickable: true);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}
