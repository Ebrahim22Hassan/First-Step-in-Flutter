import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  final List<bool> _selection = [true, false, false];
  String? tip;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: const Center(child: Text('Percentage Calculator')),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (tip != null)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          tip!,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    const Text('Total'),
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        decoration:
                            const InputDecoration(hintText: 'Enter number'),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: ToggleButtons(
                        isSelected: _selection,
                        onPressed: updateSelection,
                        children: const [
                          Text('10%'),
                          Text('15%'),
                          Text('20%'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: calculate,
                      child: const Text(
                        'Calculate',
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            //print("Error");
          } else {
            return const CircularProgressIndicator();
          }
          return Container();
        },
      ),
    );
  }

  void updateSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _selection.length; i++) {
        _selection[i] = selectedIndex == i;
      }
    });
  }

  void calculate() {
    final amount = double.parse(controller.text);
    final selectedIndex = _selection.indexWhere((element) => element);
    final percentage = [0.1, 0.15, 0.2][selectedIndex];
    final total = (amount * percentage).toStringAsFixed(2);

    setState(() {
      tip = total;
    });
  }
}

///Hosting Website Link:
///https://first-web-deployment-4e780.web.app
