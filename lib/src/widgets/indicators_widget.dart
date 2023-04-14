import 'package:fan_carousel_image_slider/src/models/fan_carousel_indicator_type.dart';
import 'package:flutter/material.dart';

class IndicatorsWidget extends StatelessWidget {
  const IndicatorsWidget({
    super.key,
    required this.activeIndicatorType,
    required this.indicatorType,
    required this.indicatorSize,
    required this.activeIndicatorColor,
    required this.indicatorDeactiveColor,
    required this.sliderDuration,
    required this.imagesLink,
    required this.actualIndex,
  });

  final FanCarouselIndicatorType activeIndicatorType;
  final FanCarouselIndicatorType indicatorType;
  final double indicatorSize;
  final int actualIndex;
  final Duration sliderDuration;
  final Color activeIndicatorColor;
  final Color indicatorDeactiveColor;
  final List<String> imagesLink;

  double get _activeIndicatorSizeHeight {
    return indicatorSize;
  }

  double get _activeIndicatorSizeWidth {
    switch (activeIndicatorType) {
      case FanCarouselIndicatorType.circular:
        return indicatorSize;
      case FanCarouselIndicatorType.linear:
        return indicatorSize * 2;
    }
  }

  double get _indicatorSizeHeight {
    return indicatorSize;
  }

  double get _indicatorSizeWidth {
    switch (indicatorType) {
      case FanCarouselIndicatorType.circular:
        return indicatorSize;
      case FanCarouselIndicatorType.linear:
        return indicatorSize * 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.center,
        children: imagesLink.asMap().entries.map((entire) {
          return AnimatedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            duration: sliderDuration,
            width: (entire.key != actualIndex) ? _indicatorSizeWidth : _activeIndicatorSizeWidth,
            height: (entire.key != actualIndex) ? _indicatorSizeHeight : _activeIndicatorSizeHeight,
            curve: Curves.bounceInOut,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: (entire.key != actualIndex)
                  ? Colors.transparent
                  : activeIndicatorColor,
              border: (entire.key != actualIndex)
                  ? Border.all(color: indicatorDeactiveColor, width: 1)
                  : null,
              borderRadius: BorderRadius.circular(100.0)
            ),
          );
        }).toList());
  }
}
