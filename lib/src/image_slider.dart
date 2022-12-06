import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets/arrow_navs.dart';
import 'widgets/indicators_widget.dart';
import 'widgets/slide_widget.dart';

class FanCarouselImageSlider extends StatefulWidget {
  const FanCarouselImageSlider({
    super.key,
    required this.imagesLink,
    required this.isAssets,
    this.showIndicator = true,
    this.showArrowNav = false,
    this.initalPageIndex = 1,
    this.sliderHeight = 500,
    this.sliderWidth = double.infinity,
    this.turns = 250,
    this.sidesOpacity = 0.8,
    this.imageRadius = 40,
    this.imageFitMode = BoxFit.cover,
    this.slideViewportFraction = 0.7,
    this.sliderDuration = const Duration(milliseconds: 600),
    this.indicatorActiveColor = Colors.pink,
    this.indicatorDeactiveColor = Colors.grey,
    this.autoPlayInterval = const Duration(milliseconds: 3000),
    this.autoPlay = true,
    this.userCanDrag = true,
  })  : assert(imagesLink.length > 0),
        assert(initalPageIndex < (imagesLink.length - 1) && initalPageIndex > 0);

  /// List of images to be shown in the slider; Accepts two types of link.
  /// For example: `https://...jpg` for online images and `assets/...` for local images.
  final List<String> imagesLink;

  /// Specifies the type of image addresses in [imagesLink].
  /// Must be `false` if [imagesLink] contains online images.
  /// Must be `true` if [imagesLink] contains local images.
  final bool isAssets;

  /// The initial page to show when first creating the [FanCarouselImageSlider].
  /// Defaults to 1.
  final int initalPageIndex;

  /// Set as the image slider height.
  /// Defaults to 500.
  final double sliderHeight;

  /// Set as the image slider width.
  /// Defaults to double.infinity.
  final double sliderWidth;

  /// The corners of images will round according to this value.
  /// Defaults to 40.
  final double imageRadius;

  /// Determines the relative rotation of the sides images.
  /// Defaults to 250.
  final double turns;

  /// Determines the opacity of the sides images.
  /// Defaults to 0.8.
  final double sidesOpacity;

  /// Determines the value of the [fit] property of the images
  /// Defaults to BoxFit.cover.
  final BoxFit imageFitMode;

  /// The fraction of the viewport that each page should occupy.
  /// Defaults to 0.7.
  final double slideViewportFraction;

  /// This Duration type value, use for all animations in [FanCarouselImageSlider].
  /// Defaults to Duration(milliseconds: 600).
  final Duration sliderDuration;

  /// Determines the visibility of the indicators below slider.
  /// Defaults to true
  final bool showIndicator;

  /// Determines the visibility of the arrows below slider.
  /// Defaults to false.
  final bool showArrowNav;

  /// Determines the color of the active indicator below slider.
  /// Defaults to Colors.pink.
  final Color indicatorActiveColor;

  /// Determines the color of the border of the deactive indicators below slider.
  /// Defaults to Colors.grey.
  final Color indicatorDeactiveColor;

  /// Enables auto play, sliding one page at a time.
  /// Use [autoPlayInterval] to set the timer interval.
  /// Defaults to true
  final bool autoPlay;

  /// Determines the slider autoplay timer interval;
  /// when [autoPlay] is set to true.
  /// Defaults to Duration(milliseconds: 3000).
  final Duration autoPlayInterval;

  /// Determines whether the user can change slides by dragging or not.
  /// Defaults to true.
  final bool userCanDrag;

  @override
  State<FanCarouselImageSlider> createState() => _FanCarouselImageSliderState();
}

class _FanCarouselImageSliderState extends State<FanCarouselImageSlider> {
  late PageController _pageController;
  late ValueNotifier<int> _currentIndex;

  bool _isAutoAnimate = false;
  Timer? _timer;

  _autoPlayeTimerStart() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.autoPlayInterval, (_) => _goNextPage());
  }

  @override
  void initState() {
    super.initState();

    _currentIndex = ValueNotifier<int>(widget.initalPageIndex);
    _pageController = PageController(
        initialPage: _currentIndex.value, viewportFraction: widget.slideViewportFraction);

    if (widget.autoPlay) _autoPlayeTimerStart();
  }

  _disposeData() {
    _currentIndex.dispose();
    _timer?.cancel();
  }

  @override
  void dispose() {
    _disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.sliderHeight,
          width: widget.sliderWidth,
          child: ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, actualIndex, child) => PageView.builder(
              physics: (widget.userCanDrag)
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (newIndex) {
                if (!_isAutoAnimate) (actualIndex < newIndex) ? _goNextPage() : _goPrevPage();
              },
              itemCount: widget.imagesLink.length,
              itemBuilder: (context, index) {
                return SlideWidget(
                    index: index,
                    actualIndex: actualIndex,
                    sliderDuration: widget.sliderDuration,
                    isAssets: widget.isAssets,
                    imageLink: widget.imagesLink[index],
                    imageFitMode: widget.imageFitMode,
                    imageRadius: widget.imageRadius,
                    sidesOpacity: widget.sidesOpacity,
                    turns: widget.turns);
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: widget.showArrowNav,
          child: ArrawNavs(
            goNextPage: () => _goNextPage(),
            goPrevPage: () => _goPrevPage(),
          ),
        ),
        Visibility(
          visible: widget.showIndicator,
          child: ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, value, child) => IndicatorsWidget(
              indicatorActiveColor: widget.indicatorActiveColor,
              indicatorDeactiveColor: widget.indicatorDeactiveColor,
              sliderDuration: widget.sliderDuration,
              imagesLink: widget.imagesLink,
              actualIndex: value,
            ),
          ),
        ),
      ],
    );
  }

  _goNextPage() async {
    if (_currentIndex.value < widget.imagesLink.length - 1) {
      _currentIndex.value++;
      _isAutoAnimate = true;
      await _pageController.animateToPage(_currentIndex.value,
          duration: widget.sliderDuration, curve: Curves.easeIn);
    } else {
      _currentIndex.value = 0;
      _isAutoAnimate = true;
      await _pageController.animateToPage(_currentIndex.value,
          duration: widget.sliderDuration, curve: Curves.easeIn);
    }
    _isAutoAnimate = false;
  }

  _goPrevPage() async {
    if (_currentIndex.value > 0) {
      _currentIndex.value--;
      _isAutoAnimate = true;
      await _pageController.animateToPage(_currentIndex.value,
          duration: widget.sliderDuration, curve: Curves.easeOut);
    }
    _isAutoAnimate = false;
  }
}
