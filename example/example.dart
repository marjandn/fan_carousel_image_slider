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
    'https://img.freepik.com/free-photo/lovely-woman-vintage-outfit-expressing-interest-outdoor-shot-glamorous-happy-girl-sunglasses_197531-11312.jpg?w=1800&t=st=1673886721~exp=1673887321~hmac=57318aa37912a81d9c6e8f98d4e94fb97a766bf6161af66488f4d890f88a3109',
    'https://img.freepik.com/free-photo/attractive-curly-woman-purple-cashmere-sweater-fuchsia-sunglasses-poses-isolated-wall_197531-24158.jpg?w=1800&t=st=1673886680~exp=1673887280~hmac=258c92922874ad41d856e7fdba03ce349556cf619de4074143cec958b5b4cf05',
    'https://img.freepik.com/free-photo/stylish-blonde-woman-beret-beautiful-french-girl-jacket-standing-red-wall_197531-14428.jpg?w=1800&t=st=1673886821~exp=1673887421~hmac=5e77d3fab088b29a3b19a9023289fa95c1dc2af15565f290886bab4642fa2621',
    'https://img.freepik.com/free-photo/pretty-young-girl-with-pale-skin-dark-hair-french-beret-sunglasses-polka-dot-skirt-white-top-red-shirt-walking-around-sunny-city-laughing_197531-24480.jpg?w=1800&t=st=1673886800~exp=1673887400~hmac=9a1c61de63180118c5497ce105bbb36bfbb53050111de466d5110108848f2128',
    'https://img.freepik.com/free-photo/elegant-woman-brown-coat-spring-city_1157-33434.jpg?w=1800&t=st=1673886830~exp=1673887430~hmac=cc8c28a9332e008db251bdf9c7b838b7aa5077ec7663773087a8cc56d11138ff',
    'https://img.freepik.com/free-photo/high-fashion-look-glamor-closeup-portrait-beautiful-sexy-stylish-blond-young-woman-model-with-bright-yellow-makeup-with-perfect-clean-skin-with-gold-jewelery-black-cloth_158538-2003.jpg?w=826&t=st=1673886857~exp=1673887457~hmac=3ba51578e6a1e9c58e95a6b72e492cbbc26abf8e2f116a0672113770d3f4edbe',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 100,
            ),
            FanCarouselImageSlider(
              imagesLink: sampleImages,
              isAssets: false,
              autoPlay: true,
            ),
          ],
        ),
      ),
    );
  }
}
