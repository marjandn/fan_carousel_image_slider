A fantasy carousel slider widget; only for displaying online and local images. You can use it with two different types accessible with two named constructors:

## Type 1 Demo:
<image src="https://github.com/marjandn/fan_carousel_image_slider/assets/25709266/299aa39e-bab0-4df2-98cb-8c039fa1ab7b" width=300>

## Type 2 Demo:
<image src="https://github.com/marjandn/fan_carousel_image_slider/assets/25709266/510b63d9-48c4-4e6a-ac9f-5fd345483391" width=300>

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
    'https://img.freepik.com/free-photo/lovely-woman-vintage-outfit-expressing-interest-outdoor-shot-glamorous-happy-girl-sunglasses_197531-11312.jpg',
    'https://img.freepik.com/free-photo/shapely-woman-vintage-dress-touching-her-glasses-outdoor-shot-interested-relaxed-girl-brown-outfit_197531-11308.jpg',
    'https://img.freepik.com/premium-photo/cheerful-lady-brown-outfit-looking-around-outdoor-portrait-fashionable-caucasian-model-with-short-wavy-hairstyle_197531-25791.jpg',
  ];

  // Type 1 
  FanCarouselImageSlider.sliderType1(
              imagesLink: sampleImages,
              isAssets: false,
              autoPlay: false,
              sliderHeight: 400,
              showIndicator: true,
            ),

  // Type 2
  FanCarouselImageSlider.sliderType2(
              imagesLink: sampleImages,
              isAssets: false,
              autoPlay: false,
              sliderHeight: 300,
              currentItemShadow: const [],
              sliderDuration: const Duration(milliseconds: 200),
              imageRadius: 0,
              slideViewportFraction: 1.2,
            ),
```

## Customization
Customize the FanCarouselImageSlider widget with these parameters:

```dart

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

  /// Determines the expand tapped image mode to be zoomable and display image in the original size
  /// Default to false
  final bool expandFitAndZoomable;

  /// Determines where the indicators should display, On the slider or below it
  /// Default to bottom of slider
  final bool displayIndicatorOnSlider;
```
