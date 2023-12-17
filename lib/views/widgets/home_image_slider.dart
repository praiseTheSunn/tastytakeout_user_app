

import 'package:flutter/material.dart';
import 'package:tastytakeout_user_app/view_models/MainHomeViewModel.dart';

class ImageSliderWidget extends StatelessWidget {
  final MainHomeViewModel viewModel;

  ImageSliderWidget({required this.viewModel});

  @override
  Widget build(BuildContext context) {

    return PageView.builder(
      itemCount: viewModel.images.length,
      itemBuilder: (context, index) {
        return Image.asset(
          viewModel.images[index],
          fit: BoxFit.fitWidth,
        );
      },
    );
  }
}