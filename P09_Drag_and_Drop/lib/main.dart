import 'package:drag_and_drop/basic_drag_drop.dart';
import 'package:drag_and_drop/home_page.dart';
import 'package:drag_and_drop/stacked.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Drag & Drop', home: const HomePage(), routes: {
      "basic": (context) => const BasicDragAndDrop(),
      "stacked": (context) => const StackedDragAndDrop()
    });
  }
}
