import 'package:flutter/material.dart';

class CircularColor extends StatelessWidget {
  final Color colorName;

  const CircularColor({Key? key, required this.colorName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color: colorName,
          borderRadius: BorderRadius.all(Radius.circular(1000))),
    );
  }
}