import 'package:flutter/material.dart';
import 'package:restaurant_app/models/menu_item.dart';
import 'package:restaurant_app/widgets/molecules/menu_item_card.dart';

class MenuList extends StatelessWidget {
  final List<MenuItem> items;

  const MenuList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(items.length, (index) {
        return MenuItemCard(name: items[index].name, price: '10.000');
      }),
    );
  }
}
