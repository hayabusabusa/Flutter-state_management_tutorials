import 'package:state_management_tutorials/models/cart.dart';
import 'package:state_management_tutorials/models/src/item.dart';
import 'package:test/test.dart';

void main() {
  test('adding item increases total cost', () {
    final cart = CartModel();
    final startingPrice = cart.totalPrice;

    cart.addListener(() {
        expect(cart.totalPrice, greaterThan(startingPrice));
    });
    cart.add(Item(42));
  });
}