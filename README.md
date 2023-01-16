A fantasy carousel slider widget; only for displaying online and local images. 

<image src="https://user-images.githubusercontent.com/25709266/212736044-0075701e-da20-4f37-9f50-27ff4f29639f.gif" width=300>

## Installation

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  flutter:
    sdk:
  fan_carousel_image_slider: any
```

Import the fantasy carousel package like this: 

```dart
  import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
```

## Usage

Simply create a FanCarouselImageSlider widget, and pass the required params:

```dart
  static const List<String> sampleImages = [
    "https://images.unsplash.com/photo-1557700836-25f2464e845d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=627&q=80",
    "https://images.unsplash.com/photo-1669462277329-f32f928a4a79?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1542840410-3092f99611a3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  ];

  FanCarouselImageSlider(
            imagesLink: sampleImages,
            isAssets: false,
          )
```

## Customization
Customize the FanCarouselImageSlider widget with these parameters:

```dart
// List of images to be shown in the slider; Accepts two types of link.
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
```