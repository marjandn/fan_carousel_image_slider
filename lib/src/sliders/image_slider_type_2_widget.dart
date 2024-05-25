import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/slider_type_2/slide_widget.dart';

class ImageSliderType2Widget extends StatefulWidget {
  const ImageSliderType2Widget({
    super.key,
    required this.imagesLink,
    required this.isAssets,
    required this.initalPageIndex,
    required this.sliderHeight,
    required this.sliderWidth,
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

  final double sidesOpacity;

  final BoxFit imageFitMode;

  final double slideViewportFraction;

  final Duration sliderDuration;

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
  State<ImageSliderType2Widget> createState() => _ImageSliderType2State();
}

class _ImageSliderType2State extends State<ImageSliderType2Widget> {
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
              SizedBox(
                height: 50,
                child: ValueListenableBuilder(
                  valueListenable: _currentIndex,
                  builder: (BuildContext context, int value, Widget? child) => ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: widget.imagesLink
                        .asMap()
                        .entries
                        .map((entire) => GestureDetector(
                              onTap: () => _goSpecificPage(entire.key),
                              child: AnimatedContainer(
                                duration: widget.sliderDuration,
                                width: entire.key != value ? 40 : 50,
                                height: 45,
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  border: entire.key != value
                                      ? null
                                      : Border.all(color: widget.indicatorActiveColor, width: 2),
                                  image: DecorationImage(
                                    image: (!widget.isAssets)
                                        ? NetworkImage(entire.value)
                                        : AssetImage(entire.value) as ImageProvider,
                                    fit: widget.imageFitMode,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _goSpecificPage(int index) async {
    _currentIndex.value = index;
    _isAutoAnimate = true;

    await _pageController.animateToPage(_currentIndex.value,
        duration: widget.sliderDuration, curve: Curves.easeIn);

    _isAutoAnimate = false;
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
