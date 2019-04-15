import 'dart:collection';

class MenuDetail {
  final String menu_name;
  const MenuDetail(this.menu_name);
  @override
  String toString() => "$menu_name";
}

class Menu {
  final List<MenuDetail> _menusDetail = <MenuDetail>[];

  Menu();

  Menu.clone(Menu menu) {
    _menusDetail.addAll(menu._menusDetail);
  }

  int get menuCount => _menusDetail.length;

  UnmodifiableListView<MenuDetail> get menus =>
      UnmodifiableListView(_menusDetail);

  void add(String menu_name) {
    _updateMenuName(menu_name);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$_menusDetail";
  }

  void _updateMenuName(String menu_name) {
    for (var i = 0; i < _menusDetail.length; i++) {
      final menudetail = _menusDetail[i];
      if (menu_name == menudetail.menu_name) {
        return;
      }
    }
    _menusDetail.add(MenuDetail(menu_name));
  }
}
