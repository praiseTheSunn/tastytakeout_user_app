// advertisement_page.dart

import 'package:flutter/material.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';

class AdvertisementPage extends StatelessWidget {
  final String imageUrl;

  AdvertisementPage({required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        title: 'Advertisement',
        // Add necessary onPressed callbacks for the app bar icons
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Advertisement Image
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              height: 200, // Set the desired height
            ),
            // 8 pairs of information related to this advertisement
            AdvertisementInfoPair('Info 1', 'Detail 1'),
            AdvertisementInfoPair('Info 2', 'Detail 2'),
            // Add more pairs as needed
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
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(value),
        ],
      ),
    );
  }
}
