import 'package:flutter/material.dart';

class MenuItemCard extends StatelessWidget {
  final String name;
  final String price;

  const MenuItemCard({Key? key, required this.name, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Image.network(
            'https://picsum.photos/200/100',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.all(2)),
              Text('IDR $price', style: const TextStyle(fontSize: 8)),
            ],
          ),
        )
      ],
    ));
  }
}
