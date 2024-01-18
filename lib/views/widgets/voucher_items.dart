import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/models/dto/EventModel.dart';

class VoucherItem extends StatelessWidget {
  Voucher voucher;

  VoucherItem({super.key, required this.voucher});

  var isClick = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(10.0)),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Icon(Icons.card_giftcard, size: 50),
          SizedBox(width: 10.0),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voucher.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(voucher.description,maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text('Số lượng: ' +
                    voucher.quantity.toString() +
                    '-' +
                    'Đã dùng: ' +
                    voucher.used_quantity.toString()),
                Obx(
                  () => Container(
                    child: isClick.value
                        ? Container(
                            margin: EdgeInsets.only(top: 5.0,left: 5.0),
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          child: Text(voucher.code,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        )
                        : TextButton(
                            onPressed: () {
                              isClick.value = true;
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.all(5.0),
                              textStyle: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            child: Text('Nhận mã giảm giá'),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
