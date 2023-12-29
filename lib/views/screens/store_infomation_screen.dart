import 'package:flutter/material.dart';

class StoreInfomationScreen extends StatelessWidget {
  const StoreInfomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Shop'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset('lib/resources/food1.jpg',
                      width: 100, height: 100, fit: BoxFit.cover),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Coffee Shop',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('123 Nguyễn Văn Cừ, Quận 1, TP.HCM'),
                    Text('012345678'),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.message),
                            iconSize: 30,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_outline),
                            iconSize: 30,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Danh Sách Món Ăn',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true,
              // Sử dụng shrinkWrap để ListView không chiếm toàn bộ không gian// Tắt khả năng scroll của ListView
              itemCount: 3,
              // Số lượng món ăn, có thể thay đổi tùy theo data của bạn
              itemBuilder: (context, index) {
                // Sử dụng data thật của bạn ở đây
                return ListTile(
                  leading: Image.asset(
                      'lib/resources/food' + (index + 1).toString() + '.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover),
                  title: Text('Tên Món Ăn'),
                  subtitle: Text('25.000đ'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
