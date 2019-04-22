import './menus.dart';

class MenuDetailList {
  final Menus menu;
  MenuDetailList(this.menu);

  @override
  String toString() => "${menu.menu_name}";
}
