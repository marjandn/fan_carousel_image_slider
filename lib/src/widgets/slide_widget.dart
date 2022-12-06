import 'dart:math';

import 'package:flutter/material.dart';

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
  });

  final int index;
  final int actualIndex;
  final Duration sliderDuration;
  final bool isAssets;
  final String imageLink;
  final BoxFit imageFitMode;
  final double imageRadius;
  final double sidesOpacity;
  final double turns;

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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(imageRadius),
              image: DecorationImage(
                image:
                    (!isAssets) ? NetworkImage(imageLink) : AssetImage(imageLink) as ImageProvider,
                fit: imageFitMode,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BoxShadow>? _getSlideBoxShadow(index, actualIndex) => (index == actualIndex)
      ? const [
          BoxShadow(offset: Offset(1, 1), color: Colors.grey, blurRadius: 10),
          BoxShadow(offset: Offset(-1, -1), color: Colors.grey, blurRadius: 10),
        ]
      : null;

  double _getSlideTurn(int currentIndex, actualCurrentIndex) => (currentIndex < actualCurrentIndex)
      ? -pi / turns
      : (currentIndex > actualCurrentIndex)
          ? pi / turns
          : 0;
}
