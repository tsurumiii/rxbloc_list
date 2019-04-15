import 'package:flutter/widgets.dart';
import './menu_bloc.dart';

class BlocProvider extends InheritedWidget {
  final MenuBloc menuBloc;

  BlocProvider({
    Key key,
    MenuBloc menuBloc,
    Widget child,
  })  : menuBloc = menuBloc ?? MenuBloc(),
        super(
          key: key,
          child: child,
        );
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MenuBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .menuBloc;
  }
}
