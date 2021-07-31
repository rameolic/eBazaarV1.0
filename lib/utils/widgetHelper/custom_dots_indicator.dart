import 'dart:math';
import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_colors.dart';

class CustomDotsIndicator extends AnimatedWidget {
  int indexValue = 0;

  CustomDotsIndicator(
      {this.controller,
      this.itemCount,
      this.onPageSelected,
      this.color: colorPrimary,
      this.indexValue})
      : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 24.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;

    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: Container(
          width: controller.page != null &&  controller.page.toInt() == index ? 15 : 9,  //_kDotSize * zoom
          height: controller.page != null && controller.page.toInt() == index ? 9 : 9,  // _kDotSize * zoom
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: controller.page != null && controller.page.toInt() == index ? color : colorDarkGrey,
          ),
          child: new InkWell(
            onTap: () => onPageSelected(index),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
