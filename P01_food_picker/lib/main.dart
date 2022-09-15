import 'dart:math';
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
  List<String> food = [
    'Chicken',
    'Rice',
    'Pasta',
    'Meat',
  ];
  int? currentIndex;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What To Eat Today?!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            if (currentIndex != null)

              ///***
              Text(
                food[currentIndex!],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.end,
              ),
            const Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            ElevatedButton(
              onPressed: () {
                updateIndex();
              },
              style: ButtonStyle(
                //overlayColor: MaterialStateProperty.all<Color>(Colors.green),
                backgroundColor: getColor(Colors.green, Colors.white),
                foregroundColor: getColor(Colors.white, Colors.green),
              ),
              child: const Text(
                'Pick Food',
              ),
            ),
          ],
        )),
      ),
    );
  }

  void updateIndex() {
    final random = Random();
    final index = random.nextInt(food.length);
    setState(() {
      currentIndex = index;
    });
  }

  MaterialStateProperty<Color> getColor(Color color, Color pressedColor) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return pressedColor;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }
}
