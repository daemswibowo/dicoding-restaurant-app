import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/search.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  final String username = 'Dicoding';
  final String greetings = 'Good morning!';

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 90,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(greetings, style: const TextStyle(color: Colors.black38, fontSize: 12)),
                Text(username, style: const TextStyle(color: Colors.black)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(onPressed: () => Navigator.pushNamed(context, SearchPage.name), icon:  const Icon(Icons.search),),
              ],
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
      ),
    );
  }
}
