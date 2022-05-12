import 'package:flutter/material.dart';


class SizeContainer extends StatelessWidget {
  final String sizeName;

  const SizeContainer({Key? key, required this.sizeName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(1000))),
      child: Center(
        child: Text(
          sizeName,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
