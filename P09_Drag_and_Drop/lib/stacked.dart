import 'package:flutter/material.dart';

class StackedDragAndDrop extends StatefulWidget {
  const StackedDragAndDrop({Key? key}) : super(key: key);

  @override
  State<StackedDragAndDrop> createState() => _StackedDragAndDropState();
}

class _StackedDragAndDropState extends State<StackedDragAndDrop> {
  List<Color> stack1 = [Colors.blueAccent, Colors.red];
  List<Color> stack2 = [Colors.black];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Stacked Drag & Drop"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildStack(stack1),
            buildStack(stack2),
          ],
        ),
      ),
    );
  }

  Widget buildStack(List<Color> stack) {
    return DragTarget<Color>(
      onAccept: (data) {
        if (stack.isNotEmpty && data == stack.last) return;

        setState(() {
          stack.add(data);

          final otherStacks = [stack1, stack2]..remove(stack);
          for (final stack in otherStacks) {
            stack.remove(data);
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        return

            /// main Container
            Stack(children: [
          Container(
            color: Colors.grey,
            height: 205,
            width: 205,
            child: const Center(child: Text("EMPTY")),
          ),

          ///draggable Containers
          ...stack.map(buildStackItem).toList(),
        ]);
      },
    );
  }

  Widget buildStackItem(Color color) {
    final colorBox = Container(
      color: color,
      width: 200,
      height: 200,
    );
    return Draggable(
      data: color,
      feedback: colorBox,
      childWhenDragging: const SizedBox(
        width: 200,
        height: 200,
      ),
      child: colorBox,
    );
  }
}
