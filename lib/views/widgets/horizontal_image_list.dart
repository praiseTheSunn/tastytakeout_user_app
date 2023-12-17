

import 'package:flutter/material.dart';

class HorizontalImageList extends StatelessWidget {
  final List<String> images;

  HorizontalImageList({required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            images[index],
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}


