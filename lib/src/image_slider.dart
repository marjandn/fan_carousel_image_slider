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
    this.currentItemShadow = const [
      BoxShadow(offset: Offset(1, 1), color: Colors.grey, blurRadius: 10),
      BoxShadow(offset: Offset(-1, -1), color: Colors.grey, blurRadius: 10),
    ],
    this.sideItemsShadow,
    this.isClickable = true,
    this.expandImageWidth,
    this.expandImageHeight,
    this.expandedImageFitMode = BoxFit.cover,
    this.expandedCloseBtnAlign = Alignment.bottomLeft,
    this.expandedCloseBtn,
    this.expandedCloseChild = const Padding(
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
        )),
    this.expandedCloseBtnDecoration,
  })  : assert(imagesLink.length > 0),
        assert(initalPageIndex <= (imagesLink.length - 1) && initalPageIndex >= 0);

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

  /// Determines box shadow of current (center) image.
  /// Defaults to custom BoxShadwo list.
  final List<BoxShadow>? currentItemShadow;

  /// Determines box shadow of sides image.
  /// Defaults to null.
  final List<BoxShadow>? sideItemsShadow;

  /// Determines whether the image should be clickable or not.
  /// Defaults to true
  final bool isClickable;

  /// Set as the width of the expanded image.
  /// Defaults to MediaQuery.of(context).size.width * 0.9)
  final double? expandImageWidth;

  /// Set as the height of the expanded image.
  /// Defaults to MediaQuery.of(context).size.height * 0.8
  final double? expandImageHeight;

  /// Determines the value of the [fit] property of the expanded image
  /// Defaults to BoxFit.cover.
  final BoxFit expandedImageFitMode;

  /// Determines the alignment of the close button for the expanded image
  /// Defaults to Alignment.bottomLeft
  final AlignmentGeometry expandedCloseBtnAlign;

  /// Defines a widget for the close button of the expanded image.
  /// It can be null and the default close button will be shown.
  final Widget? expandedCloseBtn;

  /// Determines the widget in the default close button container
  /// Defaults to arrow_back_ios_rounded icon
  final Widget expandedCloseChild;

  /// Determines the style of the expanded image's close button container.
  /// It can be null then the default style will be applied.
  final BoxDecoration? expandedCloseBtnDecoration;

  @override
  State<FanCarouselImageSlider> createState() => _FanCarouselImageSliderState();
}

class _FanCarouselImageSliderState extends State<FanCarouselImageSlider> {
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
