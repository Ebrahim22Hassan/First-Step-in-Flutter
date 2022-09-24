import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _imagePaths = [
    'images/01.jpg',
    'images/02.jpg',
    'images/03.jpg',
    'images/04.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
            ),
            items: _imagePaths.map((imagePath) {
              return Builder(builder: (context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(imagePath),
                );
              });
            }).toList()),
      ),
    );
  }
}
