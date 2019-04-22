import './menu_detail_list.dart';

import './menus.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class MenuDetail {
  final Menus menus;
  const MenuDetail(this.menus);
  @override
  String toString() => "$menus";
}

class MenusBloc {
  final BehaviorSubject<List<MenuDetailList>> _menusDetialList =
      BehaviorSubject<List<MenuDetailList>>.seeded(const []);

  final StreamController<MenuDetail> _menuDetailController =
      StreamController<MenuDetail>();

  MenusBloc() {
    _menuDetailController.stream.listen(_handleAddtion);
  }

  void _handleAddtion(MenuDetail menuDetail) {
    _menusDetialList.add;
  }
}
