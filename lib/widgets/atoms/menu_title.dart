import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  final String title;

  const MenuTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
