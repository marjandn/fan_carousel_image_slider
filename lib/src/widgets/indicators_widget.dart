import 'package:flutter/material.dart';

class IndicatorsWidget extends StatelessWidget {
  const IndicatorsWidget({
    super.key,
    required this.indicatorActiveColor,
    required this.indicatorDeactiveColor,
    required this.sliderDuration,
    required this.imagesLink,
    required this.actualIndex,
  });

  final int actualIndex;
  final Duration sliderDuration;
  final Color indicatorActiveColor;
  final Color indicatorDeactiveColor;
  final List<String> imagesLink;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.center,
        children: imagesLink.asMap().entries.map((entire) {
          return AnimatedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            duration: sliderDuration,
            width: 10,
            height: 10,
            curve: Curves.bounceInOut,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (entire.key != actualIndex) ? Colors.transparent : indicatorActiveColor,
              border: (entire.key != actualIndex)
                  ? Border.all(color: indicatorDeactiveColor, width: 1)
                  : null,
            ),
          );
        }).toList());
  }
}
