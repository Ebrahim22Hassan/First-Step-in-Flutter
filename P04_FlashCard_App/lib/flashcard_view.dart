import 'package:flutter/material.dart';

class FlashcardView extends StatelessWidget {
  final String text;
  final Color textColor;
  const FlashcardView({Key? key, required this.text, required this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
