import 'dart:async';
import 'package:rxdart/subjects.dart';

class MenuNameAdd {
  final String name;
  MenuNameAdd(this.name);
}

class MenuBloc {
  final StreamController<MenuNameAdd> _menuNameAddController =
      StreamController<MenuNameAdd>();
  final BehaviorSubject<String> _addMenuName =
      BehaviorSubject<String>.seeded('');
  MenuBloc() {
    _menuNameAddController.stream.listen((name) {
      print(name.name);
      _addMenuName.add(name.name);
    });
  }

  Sink<MenuNameAdd> get addname => _menuNameAddController.sink;

  Stream<String> get getMenuName => _addMenuName.stream;
}
