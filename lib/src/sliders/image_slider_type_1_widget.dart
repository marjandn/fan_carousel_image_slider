import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/slider_type_1/arrow_navs.dart';
import '../widgets/slider_type_1/indicators_widget.dart';
import '../widgets/slider_type_1/slide_widget.dart';

class ImageSliderType1Widget extends StatefulWidget {
  const ImageSliderType1Widget({
    super.key,
    required this.imagesLink,
    required this.isAssets,
    required this.showIndicator,
    required this.showArrowNav,
    required this.initalPageIndex,
    required this.sliderHeight,
    required this.sliderWidth,
    required this.turns,
    required this.sidesOpacity,
    required this.imageRadius,
    required this.imageFitMode,
    required this.slideViewportFraction,
    required this.sliderDuration,
    required this.indicatorActiveColor,
    required this.indicatorDeactiveColor,
    required this.autoPlayInterval,
    required this.autoPlay,
    required this.userCanDrag,
    required this.currentItemShadow,
    required this.sideItemsShadow,
    required this.isClickable,
    required this.expandImageWidth,
    required this.expandImageHeight,
    required this.expandedImageFitMode,
    required this.expandedCloseBtnAlign,
    required this.expandedCloseBtn,
    required this.expandedCloseChild,
    required this.expandedCloseBtnDecoration,
  });

  final List<String> imagesLink;

  final bool isAssets;

  final int initalPageIndex;

  final double sliderHeight;

  final double sliderWidth;

  final double imageRadius;

  final double turns;

  final double sidesOpacity;

  final BoxFit imageFitMode;

  final double slideViewportFraction;

  final Duration sliderDuration;

  final bool showIndicator;

  final bool showArrowNav;

  final Color indicatorActiveColor;

  final Color indicatorDeactiveColor;

  final bool autoPlay;

  final Duration autoPlayInterval;

  final bool userCanDrag;

  final List<BoxShadow>? currentItemShadow;

  final List<BoxShadow>? sideItemsShadow;

  final bool isClickable;

  final double? expandImageWidth;

  final double? expandImageHeight;

  final BoxFit expandedImageFitMode;

  final AlignmentGeometry expandedCloseBtnAlign;

  final Widget? expandedCloseBtn;

  final Widget expandedCloseChild;

  final BoxDecoration? expandedCloseBtnDecoration;

  @override
  State<ImageSliderType1Widget> createState() => _ImageSliderType1State();
}

class _ImageSliderType1State extends State<ImageSliderType1Widget> {
  late PageController _pageController;
  late ValueNotifier<int> _currentIndex;

  final ValueNotifier<bool> _isExpandSlide = ValueNotifier<bool>(false);

  bool _isAutoAnimate = false;
  Timer? _timer;

  String? expandedImage;

  _autoPlayeTimerStart() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.autoPlayInterval, (_) => _goNextPage());
  }

  @override
  void initState() {
    super.initState();

    _currentIndex = ValueNotifier<int>(widget.initalPageIndex);
    _pageController =
        PageController(initialPage: _currentIndex.value, viewportFraction: widget.slideViewportFraction);

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
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isExpandSlide,
            builder: (context, isExpand, child) {
              if (widget.autoPlay) (isExpand) ? _timer?.cancel() : _autoPlayeTimerStart();
              expandedImage = (isExpand) ? widget.imagesLink[_currentIndex.value] : null;
              return AnimatedContainer(
                  margin: const EdgeInsets.only(top: 15),
                  duration: widget.sliderDuration,
                  width: (!isExpand)
                      ? 100
                      : (widget.expandImageWidth ?? MediaQuery.of(context).size.width * 0.9),
                  height: (!isExpand)
                      ? 0
                      : (widget.expandImageHeight ?? (MediaQuery.of(context).size.height * 0.8)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.imageRadius),
                    image: (expandedImage != null)
                        ? DecorationImage(
                            image: (!widget.isAssets)
                                ? NetworkImage(expandedImage!)
                                : AssetImage(expandedImage!) as ImageProvider,
                            fit: widget.expandedImageFitMode,
                          )
                        : null,
                  ),
                  child: Visibility(visible: isExpand, child: child!));
            },
            child: Align(
              alignment: widget.expandedCloseBtnAlign,
              child: InkWell(
                onTap: () => _isExpandSlide.value = false,
                child: widget.expandedCloseBtn ??
                    Container(
                        decoration: widget.expandedCloseBtnDecoration ??
                            BoxDecoration(
                              color: const Color.fromARGB(169, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(widget.imageRadius),
                                topRight: Radius.circular(widget.imageRadius),
                              ),
                            ),
                        child: widget.expandedCloseChild),
              ),
            ),
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isExpandSlide,
          builder: (context, isExpand, child) => AnimatedOpacity(
            opacity: (!isExpand) ? 1 : 0,
            duration: widget.sliderDuration,
            child: child,
          ),
          child: Column(
            children: [
              ValueListenableBuilder<int>(
                valueListenable: _currentIndex,
                builder: (context, actualIndex, child) => SizedBox(
                  width: widget.sliderWidth,
                  height: widget.sliderHeight,
                  child: PageView.builder(
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
                        turns: widget.turns,
                        currentItemShadow: widget.currentItemShadow,
                        sideItemsShadow: widget.sideItemsShadow,
                        onSlideClick: () {
                          if (widget.isClickable && index == actualIndex) {
                            _isExpandSlide.value = true;
                          }
                        },
                      );
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
