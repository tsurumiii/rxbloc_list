import 'dart:async';
import 'package:rxdart/subjects.dart';
import './menu.dart';

class MenuNameAdd {
  final String name;
  MenuNameAdd(this.name);
}

class MenuBloc {
  final Menu _menu = Menu();

  final BehaviorSubject<List<MenuDetail>> _menuDetail =
      BehaviorSubject<List<MenuDetail>>.seeded(const []);

  final StreamController<MenuNameAdd> _menuNameAddController =
      StreamController<MenuNameAdd>();

  final BehaviorSubject<String> _addMenuName =
      BehaviorSubject<String>.seeded('');

  MenuBloc() {
    _menuNameAddController.stream.listen((name) {
      print(name.name);
      _menu.add(name.name);
      _menuDetail.add(_menu.menus);
      print('menu: $_menu.');
      _addMenuName.add(name.name);
    });
  }

  Sink<MenuNameAdd> get addname => _menuNameAddController.sink;

  Stream<String> get getMenuName => _addMenuName.stream;

  Stream<List<MenuDetail>> get getMenuList => _menuDetail.stream;
}
