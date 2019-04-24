import './menu_item.dart';

class CartItem {
  final int count;
  final MenuItem menuItem;

  CartItem(this.count, this.menuItem);

  @override
  String toString() => "${menuItem.name} x $count";
}
