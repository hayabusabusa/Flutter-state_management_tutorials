import 'dart:collection';

import 'package:state_management_tutorials/models/src/item.dart';
import 'package:scoped_model/scoped_model.dart';

/// カート内のアイテムの状態を管理する。
/// scoped_model の Model クラスを継承している。
class CartModel extends Model {
  /// Internal, private state of the cart.
  final List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// The current total price of all items
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. 
  /// This is the only way to modify the cart from outside.
  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  /// Remove all items in the cart.
  void clear() {
    _items.clear();
  }
}