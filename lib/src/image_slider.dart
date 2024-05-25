import 'package:fan_carousel_image_slider/src/enums/slider_type.dart';
import 'package:fan_carousel_image_slider/src/sliders/image_slider_type_1_widget.dart';
import 'package:flutter/material.dart';

import 'sliders/image_slider_type_2_widget.dart';

class FanCarouselImageSlider extends StatelessWidget {
  const FanCarouselImageSlider.sliderType1({
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
      BoxShadow(offset: Offset(1, 1), color: Color.fromARGB(78, 158, 158, 158), blurRadius: 10),
      BoxShadow(offset: Offset(-1, -1), color: Color.fromARGB(78, 158, 158, 158), blurRadius: 10),
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
        assert(initalPageIndex <= (imagesLink.length - 1) && initalPageIndex >= 0),
        imageSliderType = ImageSliderType.imageSliderType1;

  const FanCarouselImageSlider.sliderType2({
    super.key,
    required this.imagesLink,
    required this.isAssets,
    this.initalPageIndex = 1,
    this.sliderHeight = 500,
    this.sliderWidth = double.infinity,
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
      BoxShadow(offset: Offset(1, 1), color: Color.fromARGB(78, 158, 158, 158), blurRadius: 10),
      BoxShadow(offset: Offset(-1, -1), color: Color.fromARGB(78, 158, 158, 158), blurRadius: 10),
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
        assert(initalPageIndex <= (imagesLink.length - 1) && initalPageIndex >= 0),
        imageSliderType = ImageSliderType.imageSliderType2,
        turns = 250,
        showIndicator = true,
        showArrowNav = false;

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
  /// Used only for [ImageSliderType.imageSliderType1]
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
  /// Used only for [ImageSliderType.imageSliderType1]
  /// Defaults to true
  final bool showIndicator;

  /// Determines the visibility of the arrows below slider.
  /// Used only for [ImageSliderType.imageSliderType1]
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

  final ImageSliderType imageSliderType;

  @override
  Widget build(BuildContext context) => switch (imageSliderType) {
        ImageSliderType.imageSliderType1 => ImageSliderType1Widget(
            imagesLink: imagesLink,
            isAssets: isAssets,
            showIndicator: showIndicator,
            showArrowNav: showArrowNav,
            initalPageIndex: initalPageIndex,
            sliderHeight: sliderHeight,
            sliderWidth: sliderWidth,
            turns: turns,
            sidesOpacity: sidesOpacity,
            imageRadius: imageRadius,
            imageFitMode: imageFitMode,
            slideViewportFraction: slideViewportFraction,
            sliderDuration: sliderDuration,
            indicatorActiveColor: indicatorActiveColor,
            indicatorDeactiveColor: indicatorDeactiveColor,
            autoPlayInterval: autoPlayInterval,
            autoPlay: autoPlay,
            userCanDrag: userCanDrag,
            currentItemShadow: currentItemShadow,
            sideItemsShadow: sideItemsShadow,
            isClickable: isClickable,
            expandImageWidth: expandImageWidth,
            expandImageHeight: expandImageHeight,
            expandedImageFitMode: expandedImageFitMode,
            expandedCloseBtnAlign: expandedCloseBtnAlign,
            expandedCloseBtn: expandedCloseBtn,
            expandedCloseChild: expandedCloseChild,
            expandedCloseBtnDecoration: expandedCloseBtnDecoration),
        ImageSliderType.imageSliderType2 => ImageSliderType2Widget(
            imagesLink: imagesLink,
            isAssets: isAssets,
            initalPageIndex: initalPageIndex,
            sliderHeight: sliderHeight,
            sliderWidth: sliderWidth,
            sidesOpacity: sidesOpacity,
            imageRadius: imageRadius,
            imageFitMode: imageFitMode,
            slideViewportFraction: slideViewportFraction,
            sliderDuration: sliderDuration,
            indicatorActiveColor: indicatorActiveColor,
            indicatorDeactiveColor: indicatorDeactiveColor,
            autoPlayInterval: autoPlayInterval,
            autoPlay: autoPlay,
            userCanDrag: userCanDrag,
            currentItemShadow: currentItemShadow,
            sideItemsShadow: sideItemsShadow,
            isClickable: isClickable,
            expandImageWidth: expandImageWidth,
            expandImageHeight: expandImageHeight,
            expandedImageFitMode: expandedImageFitMode,
            expandedCloseBtnAlign: expandedCloseBtnAlign,
            expandedCloseBtn: expandedCloseBtn,
            expandedCloseChild: expandedCloseChild,
            expandedCloseBtnDecoration: expandedCloseBtnDecoration),
      };
}
