import 'package:flutter/material.dart';

class BasicDragAndDrop extends StatefulWidget {
  const BasicDragAndDrop({Key? key}) : super(key: key);

  @override
  State<BasicDragAndDrop> createState() => _BasicDragAndDropState();
}

class _BasicDragAndDropState extends State<BasicDragAndDrop> {
  double height = 200;
  double width = 200;
  Color targetColor = Colors.black;
  Color draggedColor = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Drag & Drop"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DragTarget<Color>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: width,
                  height: height,
                  color: targetColor,
                );
              },

              /// Container color after drop
              onAccept: (data) {
                setState(() {
                  targetColor = data;
                });
              },
            ),
            IgnorePointer(
              // true == can't click
              ignoring: targetColor == Colors.black ? false : true,
              child: Opacity(
                opacity: targetColor == Colors.black ? 1 : 0,
                child: Draggable<Color>(
                  /// data to be dropped (here we drop color only)
                  data: draggedColor,

                  /// container while dragging
                  feedback: Container(
                    height: height,
                    width: width,
                    color: Colors.deepOrange,
                  ),

                  /// child remaining after dragging
                  childWhenDragging: Container(
                    height: height,
                    width: width,
                    color: Colors.grey,
                  ),

                  /// dragged container
                  child: Container(
                    height: height,
                    width: width,
                    color: draggedColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
