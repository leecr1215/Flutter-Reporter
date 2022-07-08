import 'package:flutter/material.dart';

class BackFAB extends StatelessWidget {
  const BackFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          margin: const EdgeInsets.only(left: 30),
          child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.keyboard_backspace))),
    );
  }
}
