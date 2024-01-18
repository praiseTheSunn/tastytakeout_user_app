// advertisement_page.dart

import 'package:flutter/material.dart';
import 'package:tastytakeout_user_app/helper/date_helper.dart';
import 'package:tastytakeout_user_app/models/dto/EventModel.dart';
import 'package:tastytakeout_user_app/views/widgets/voucher_items.dart';

class AdvertisementPage extends StatelessWidget {
  final EventModel eventModel;

  AdvertisementPage({required this.eventModel});

  @override
  Widget build(BuildContext context) {
    final String beginDate =
        DateHelper.getFormattedDate(DateTime.parse(eventModel.start_date));
    final String endDate;

    if (eventModel.start_date == eventModel.end_date) {
      endDate = 'Không xác định';
    } else {
      endDate =
          DateHelper.getFormattedDate(DateTime.parse(eventModel.end_date));
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Sự kiện khuyến mãi"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        // Add necessary onPressed callbacks for the app bar icons
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8.0),
            Text(
              eventModel.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Colors.grey.shade300,
                    width: 0.0,
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                eventModel.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Image.asset(
                      'lib/resources/tasty_takeout_icon.png',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            // 8 pairs of information related to this advertisement
            AdvertisementInfoPair('Bắt đầu từ ngày', beginDate),
            AdvertisementInfoPair('Kết thúc vào ngày', endDate),
            AdvertisementInfoPair('Thông tin chi tiết', eventModel.description),
            AdvertisementInfoPair('Các Vouchers trong chương trình', ''),
            // Add more pairs as needed
            ListView.builder(
              itemCount: eventModel.translatedVoucher.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                print(eventModel.voucher[index].runtimeType);
                print(eventModel.voucher[index]);
                return VoucherItem(voucher: eventModel.translatedVoucher[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AdvertisementInfoPair extends StatelessWidget {
  final String label;
  final String value;

  AdvertisementInfoPair(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text(label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(value),
        ],
      ),
    );
  }
}
