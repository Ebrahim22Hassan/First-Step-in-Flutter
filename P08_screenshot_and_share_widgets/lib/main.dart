import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cardController = ScreenshotController();
  final _textController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ScreenShot'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Text Widget to be shared
                Screenshot(
                  controller: _textController,
                  child: const Text(
                    'TEXT',
                    style: TextStyle(
                      fontSize: 50,
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                /// Card Widget to be shared
                Screenshot(
                  controller: _cardController,
                  child: Card(
                    color: Colors.orangeAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Image.asset('images/screenshot.png'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// Button to share TEXT widget
                ElevatedButton(
                  onPressed: () async {
                    final textFile = await _textController.capture();
                    _shareScreenshot(textFile!);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: const Text('Share TEXT Widget'),
                ),
                const SizedBox(
                  height: 10,
                ),

                /// Button to share CARD widget
                ElevatedButton(
                    onPressed: () async {
                      final imageFile = await _cardController.capture();
                      _shareScreenshot(imageFile!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    child: const Text('Share CARD Widget')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _shareScreenshot(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    File image = File('${directory.path}/imageT.jpg');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path], text: 'SHARED');
  }
}
