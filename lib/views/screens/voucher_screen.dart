import 'package:flutter/material.dart';

import '../../models/dto/Voucher.dart';

class VoucherScreen extends StatelessWidget {
  VoucherScreen({super.key});

  final List<Voucher> vouchers = [
    Voucher(
      discount: 'Giảm 20K cho đơn 50K',
      validity: 'Đến hết ngày 12/11/2023',
      condition: 'X1',
      detail: 'Áp dụng với tất cả cửa hàng',
    ),
    Voucher(
      discount: 'Miễn phí vận chuyển',
      validity: 'Cho các đơn hàng từ 2 món',
      condition: 'X1',
      detail: 'Áp dụng cho đơn hàng trên 100K',
    ),
    Voucher(
      discount: 'Giảm 10K cho Trà sữa',
      validity: 'Áp dụng với tất cả cửa hàng',
      condition: 'X2',
      detail: 'Không giới hạn số lượng sử dụng',
    ),
    // Bạn có thể thêm các voucher khác tương tự...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher Page'),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.card_giftcard), // Thay đổi icon tùy theo nhu cầu
              title: Text(vouchers[index].discount),
              subtitle: Text(vouchers[index].validity),
              trailing: Text(vouchers[index].detail),
            ),
          );
        },
      ),
    );
  }
}
