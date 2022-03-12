/*/* import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return  Positioned(
        left : position.dx,
        top  : position.dy ,
        child : Draggable(
            feedback: FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
            child: Container(
              child : FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
            ),
            childWhenDragging: Container(),
            onDragEnd: (details){
              setState(() {
                position = details.offset;
              });
              print(position);
              print(position.dx);
              print(position.dy);
            }))
  }
}
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: PhysicsCardDragDemo()));
}

class PhysicsCardDragDemo extends StatelessWidget {
  const PhysicsCardDragDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const DraggableCard(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: widget.child,
      child: widget.child,

    );
  }
}
*/