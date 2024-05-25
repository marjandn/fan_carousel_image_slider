import 'package:flutter/material.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FanCarouselImageSlider',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<String> sampleImages = [
    'https://img.freepik.com/free-photo/lovely-woman-vintage-outfit-expressing-interest-outdoor-shot-glamorous-happy-girl-sunglasses_197531-11312.jpg',
    'https://img.freepik.com/free-photo/shapely-woman-vintage-dress-touching-her-glasses-outdoor-shot-interested-relaxed-girl-brown-outfit_197531-11308.jpg',
    'https://img.freepik.com/premium-photo/cheerful-lady-brown-outfit-looking-around-outdoor-portrait-fashionable-caucasian-model-with-short-wavy-hairstyle_197531-25791.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              'FanCarouselImageSlider Type1:',
              style: TextStyle(fontSize: 20),
            ),
            FanCarouselImageSlider.sliderType1(
              imagesLink: sampleImages,
              isAssets: false,
              autoPlay: false,
              sliderHeight: 400,
              showIndicator: true,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'FanCarouselImageSlider Type2:',
              style: TextStyle(fontSize: 20),
            ),
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
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
