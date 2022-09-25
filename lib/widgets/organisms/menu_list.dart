import 'package:flutter/material.dart';
import 'package:restaurant_app/models/menu_list_item.dart';
import 'package:restaurant_app/widgets/molecules/menu_item_card.dart';

class MenuList extends StatelessWidget {
  final List<MenuListItem>? items;

  const MenuList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemLength = items?.length;

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(itemLength!, (index) {
        return MenuListItemCard(name: items?[index].name ?? "", price: '10.000');
      }),
    );
  }
}
