import 'package:flutter/material.dart';

class Kebab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => print('test'),
        borderRadius: BorderRadius.circular(50),
        child: Icon(Icons.more_vert)
    );
  }
}