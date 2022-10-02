import 'package:flutter/material.dart';

class MoleculeNoInternetAlert extends StatelessWidget {
  final Function onTryAgain;

  const MoleculeNoInternetAlert({super.key, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ouch! Something happen.."),
      content:
          const Text('Cannot get data, please check your internet connection'),
      actions: [
        TextButton(
            onPressed: () => onTryAgain(), child: const Text('Try again'))
      ],
    );
  }
}
