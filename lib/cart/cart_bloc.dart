import 'dart:async';
import '../model/menu_item.dart';
import 'package:rxdart/rxdart.dart';
import './cart_service.dart';
import '../model/cart_item.dart';

class CartAddtion {
  final MenuItem menuItem;
  final int count;
  CartAddtion(this.menuItem, [this.count = 1]);
}

class CartBloc {
  final _cart = CartService();

  final BehaviorSubject<List<CartItem>> _items =
      BehaviorSubject<List<CartItem>>.seeded(const []);

  final BehaviorSubject<int> _itemCount = BehaviorSubject<int>.seeded(0);

  final StreamController<CartAddtion> _cartAddtionController =
      StreamController<CartAddtion>();

  final StreamController<CartAddtion> _cartRemoveController =
      StreamController<CartAddtion>();

  CartBloc() {
    _cartAddtionController.stream.listen(_handleAddtion);

    _cartRemoveController.stream.listen(_handleRemove);
  }

  Sink<CartAddtion> get cartAddtion => _cartAddtionController.sink;

  Sink<CartAddtion> get cartRemove => _cartRemoveController.sink;

  ValueObservable<int> get itemCount =>
      _itemCount.distinct().shareValueSeeded(0);

  ValueObservable<List<CartItem>> get items => _items.stream;

  void dispose() {
    _items.close();
    _itemCount.close();
    _cartAddtionController.close();
  }

  void _handleAddtion(CartAddtion addtion) {
    print("1 ${addtion.menuItem.name}");
    print("2 ${addtion.count}");
    _cart.add(addtion.menuItem, addtion.count);
    print(_cart.items);
    print(_cart.itemCount);
    _items.add(_cart.items);
    _itemCount.add(_cart.itemCount);
  }

  void _handleRemove(CartAddtion addtion) {
    print("1 ${addtion.menuItem.name}");
    print("2 ${addtion.count}");
    _cart.remove(addtion.menuItem, addtion.count);
    print(_cart.items);
    print(_cart.itemCount);
    _items.add(_cart.items);
    _itemCount.add(_cart.itemCount);
  }
}
