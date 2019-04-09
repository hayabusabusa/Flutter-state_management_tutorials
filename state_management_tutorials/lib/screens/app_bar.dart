import 'package:flutter/material.dart';

/// カスタムした App Bar
class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.display4),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          // Navigator.pushNamed()
          // NavigationController.push みたいな遷移になる
          // 画面の左端スワイプが有効になる
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        )
      ],
    );
  }
}