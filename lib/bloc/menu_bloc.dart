import 'dart:async';
import 'package:rxdart/subjects.dart';
// import './menu.dart';
import '../model/menu_item.dart';

class MenuBloc {
  // final Menu _menu = Menu();

  // final BehaviorSubject<List<MenuDetail>> _menuDetail =
  //     BehaviorSubject<List<MenuDetail>>.seeded(const []);

  final StreamController<MenuItem> _menuNameAddController =
      StreamController<MenuItem>();

  final BehaviorSubject<List<MenuItem>> _menuDetail =
      BehaviorSubject<List<MenuItem>>.seeded(const []);

  final BehaviorSubject<List> _addMenuName = BehaviorSubject<List>.seeded([]);

  MenuBloc() {
    _menuNameAddController.stream.listen((menu) {
      print(menu.price);
      _menuDetail.add([menu]);
      _addMenuName.add([menu.name, menu.price, menu.image]);
    });
  }

  Sink<MenuItem> get addname => _menuNameAddController.sink;

  Stream<List> get getMenuName => _addMenuName.stream;

  Stream<List<MenuItem>> get menuList => _menuDetail.stream;

  // Stream<List<MenuDetail>> get getMenuList => _menuDetail.stream;
}
