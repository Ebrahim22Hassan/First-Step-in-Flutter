import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///minAndroidSDK 19

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('WebView App'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () async {
                    if (await controller.canGoBack()) {
                      controller.goBack();
                    }
                  },
                  icon: const Icon(Icons.chevron_left)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () async {
                    await controller.reload();
                  },
                  icon: const Icon(Icons.refresh)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () async {
                    if (await controller.canGoForward()) {
                      controller.goForward();
                    }
                  },
                  icon: const Icon(Icons.chevron_right)),
            ),
          ],
        ),
        body: WebView(
          initialUrl: "https://www.google.com/",
          onWebViewCreated: (controller) => this.controller = controller,
        ),
      ),
    );
  }
}
