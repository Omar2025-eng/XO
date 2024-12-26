import 'package:flutter/material.dart';

class BoardButton extends StatefulWidget {
  String text;
  int index;
  Function onButtonClick;
  BoardButton({super.key, required this.text ,required this.index, required this.onButtonClick});

  @override
  State<BoardButton> createState() => _BoardButtonState();
}

class _BoardButtonState extends State<BoardButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child:
    Padding(
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(onPressed: () {
        widget.onButtonClick(widget.index);
      }, child: Text(widget.text,
        style: TextStyle(
            fontSize: 30
        ),
      )),
    ));
  }
}