import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _fontSize = 30;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Change font Size with Slider')),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    style: TextStyle(fontSize: _fontSize),
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "Type here",
                    ),
                  ),
                ),
                Slider(
                  value: _fontSize,
                  onChanged: (newSize) {
                    setState(() {
                      _fontSize = newSize;
                    });
                  },
                  min: 30,
                  max: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
