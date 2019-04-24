import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import '../model/cart_item.dart';
import '../model/menu_item.dart';

class CartService {
  final List<CartItem> _items = <CartItem>[];

  Set<VoidCallback> _listeners = Set();

  CartService();

  int get itemCount => _items.fold(0, (sum, el) => sum + el.count);

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  void add(MenuItem menuItem, [int count = 1]) {
    _updateCount(menuItem, count);
  }

  void addListener(VoidCallback listener) => _listeners.add(listener);

  void remove(MenuItem menuItem, [int count = 1]) {
    print('3 remove: ${menuItem.name} $count');
    _updateCount(menuItem, -count);
  }

  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  @override
  String toString() => "$items";

  void _notifyListeners() {
    print('_notifyListeners');
    for (final listener in _listeners) {
      listener();
    }
  }

  void _updateCount(MenuItem menuItem, int count) {
    print('4 _updateCount: $count');
    if (count == 0) return;
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      if (menuItem.name == item.menuItem.name) {
        final newCount = item.count + count;
        print('newCount: $newCount: $i');
        if (newCount <= 0) {
          _items.removeAt(i);
          print('0 = remove');
          _notifyListeners();
        }
        _items[i] = CartItem(newCount, item.menuItem);
        _notifyListeners();
        return;
      }
    }
    if (count <= 0) return;
    _items.add(CartItem(max(count, 0), menuItem));
    _notifyListeners();
  }
}
