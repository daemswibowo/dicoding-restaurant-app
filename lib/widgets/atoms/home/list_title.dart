import 'package:flutter/material.dart';

class ListTitle extends StatelessWidget {
  const ListTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Recommended restaurant for you!')
      ],
    );
  }
}
