import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flash_card_app/flashcard_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class Flashcard {
  final String question;
  final String answer;

  Flashcard({required this.question, required this.answer});
}

class _MyAppState extends State<MyApp> {
  final List<Flashcard> _flashcard = [
    Flashcard(question: "Question1", answer: "Answer1"),
    Flashcard(question: "Question2", answer: "Yes2"),
    Flashcard(question: "Question3", answer: "No3"),
    Flashcard(question: "Question4", answer: "Maybe4"),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Flash Card App')),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: 300,
                height: 300,
                child: FlipCard(
                  front: FlashcardView(
                    text: _flashcard[currentIndex].question,
                    textColor: Colors.deepOrangeAccent,
                  ),
                  back: FlashcardView(
                    text: _flashcard[currentIndex].answer,
                    textColor: Colors.deepPurpleAccent,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: prevCard,
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('Prev'),
                ),
                OutlinedButton.icon(
                  onPressed: nextCard,
                  icon: const Icon(Icons.chevron_right),
                  label: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void nextCard() {
    setState(() {
      currentIndex =
          currentIndex + 1 < _flashcard.length ? currentIndex + 1 : 0;
    });
  }

  void prevCard() {
    setState(() {
      currentIndex =
          currentIndex - 1 >= 0 ? currentIndex - 1 : _flashcard.length - 1;
    });
  }
}
