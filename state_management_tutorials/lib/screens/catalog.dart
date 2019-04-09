import 'package:flutter/material.dart';
import 'package:state_management_tutorials/models/cart.dart';
import 'package:state_management_tutorials/models/src/item.dart';
import 'package:state_management_tutorials/screens/app_bar.dart';
import 'package:scoped_model/scoped_model.dart';

class MyCatalog extends StatelessWidget {
  MyCatalog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => MyListItem(index)
            ),
          )
        ],
      )
    );
  }
}

/// カタログ画面内で表示するアイテムのリストのセル
/// 
/// [_AddButton] Widget を通じてカートに [item] を追加する
class MyListItem extends StatelessWidget {
  final int index;

  final Item item;

  MyListItem(
    this.index, {
    Key key
  }) : item = Item(index),
        super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: Theme.of(context).textTheme.title),
            ),
            SizedBox(width: 24),
            _AddButton(item: item)
          ],
        ),
      ),
    );
  }
}

/// セルの右に表示するボタン
/// 
/// item がカートに追加されているかどうかで処理を変える
/// [CartModel.add()] がタップされた時に走る
class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScopedModel<T> で指定された Model が流れてくる
    // カートの中身が変わるたびに UI を変更する必要があるので、
    // ScopedModelDescendant Widget を使う
    return ScopedModelDescendant<CartModel>(
      // context: build メソッドのものと同じ
      // child: 先に構築しておきたい Widget subtree を指定
      // cart: ここに任意のモデルを渡す
      builder: (context, child, cart) => FlatButton(
        // カートにすでに商品が入っているかどうかを調べる
        // 入っている時は何もしなくて(null)、入っていない場合はコールバック
        onPressed: cart.items.contains(item) ? null : () => cart.add(item),
        splashColor: Colors.blue,
        child: cart.items.contains(item) ? Icon(Icons.check) : Text('ADD'),
      ) ,
    );
  }
}