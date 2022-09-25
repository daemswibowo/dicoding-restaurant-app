import 'package:flutter/material.dart';

class RuntimeError extends StatelessWidget {
  final Function onReload;
  const RuntimeError({
    Key? key,
    required this.onReload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Expanded(
                child: Center(
                  child: Column(children: [
                    const Text('Something went wrong',
                        style: TextStyle(fontSize: 18)),
                    TextButton(
                        onPressed: onReload(),
                        child: const Text('Reload')),
                  ]),
                ))));
  }
}