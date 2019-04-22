import 'dart:async';
import 'package:rxdart/subjects.dart';
// import './menu.dart';

class MenuNameAdd {
  final String name;
  final int price;
  final String image;
  MenuNameAdd(this.name, this.price, this.image);
}

class MenuBloc {
  // final Menu _menu = Menu();

  // final BehaviorSubject<List<MenuDetail>> _menuDetail =
  //     BehaviorSubject<List<MenuDetail>>.seeded(const []);

  final StreamController<MenuNameAdd> _menuNameAddController =
      StreamController<MenuNameAdd>();

  final BehaviorSubject<List> _addMenuName = BehaviorSubject<List>.seeded([]);

  MenuBloc() {
    _menuNameAddController.stream.listen((menu) {
      print(menu.price);
      _addMenuName.add([menu.name, menu.price, menu.image]);
    });
  }

  Sink<MenuNameAdd> get addname => _menuNameAddController.sink;

  Stream<List> get getMenuName => _addMenuName.stream;

  // Stream<List<MenuDetail>> get getMenuList => _menuDetail.stream;
}
