import 'dart:math';

import 'package:fan_carousel_image_slider/src/exts/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SlideWidget extends StatelessWidget {
  const SlideWidget({
    super.key,
    required this.index,
    required this.actualIndex,
    required this.sliderDuration,
    required this.isAssets,
    required this.imageLink,
    required this.imageFitMode,
    required this.imageRadius,
    required this.sidesOpacity,
    required this.turns,
    required this.currentItemShadow,
    required this.sideItemsShadow,
    required this.onSlideClick,
  });

  final Function onSlideClick;

  final int index;
  final int actualIndex;
  final Duration sliderDuration;
  final bool isAssets;
  final String imageLink;
  final BoxFit imageFitMode;
  final double imageRadius;
  final double sidesOpacity;
  final double turns;
  final List<BoxShadow>? currentItemShadow;
  final List<BoxShadow>? sideItemsShadow;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: _getSlideTurn(index, actualIndex),
      duration: sliderDuration,
      child: AnimatedContainer(
        duration: sliderDuration,
        margin: (index == actualIndex)
            ? const EdgeInsets.symmetric(horizontal: 8, vertical: 16)
            : const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(imageRadius),
          boxShadow: _getSlideBoxShadow(index, actualIndex),
        ),
        child: AnimatedOpacity(
          duration: sliderDuration,
          opacity: (index == actualIndex) ? 1 : sidesOpacity,
          child: InkWell(
            onTap: () => onSlideClick(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(imageRadius),
                image: DecorationImage(
                  image: (!isAssets)
                      ? NetworkImage(imageLink)
                      : imageLink.isSvgImage
                          ? Svg(imageLink)
                          : AssetImage(imageLink) as ImageProvider,
                  fit: imageFitMode,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BoxShadow>? _getSlideBoxShadow(index, actualIndex) =>
      (index == actualIndex) ? currentItemShadow : sideItemsShadow;

  double _getSlideTurn(int currentIndex, actualCurrentIndex) => (currentIndex < actualCurrentIndex)
      ? -pi / turns
      : (currentIndex > actualCurrentIndex)
          ? pi / turns
          : 0;
}
