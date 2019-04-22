import 'dart:collection';
import './menus.dart';
import './menus_bloc.dart';

class Menu {
  final List<MenuDetail> _menusDetail = <MenuDetail>[];

  Menu();

  Menu.clone(Menu menu) {
    _menusDetail.addAll(menu._menusDetail);
  }

  int get menuCount => _menusDetail.length;

  UnmodifiableListView<MenuDetail> get menus =>
      UnmodifiableListView(_menusDetail);

  void add(Menus menu) {
    _updateMenuName(menu);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$_menusDetail";
  }

  void _updateMenuName(Menus menu) {
    for (var i = 0; i < _menusDetail.length; i++) {
      final menudetail = _menusDetail[i];
      if (menus == menudetail.menus) {
        return;
      }
    }
    _menusDetail.add(MenuDetail(menu));
  }
}
