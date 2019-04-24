import 'package:flutter/material.dart';
import 'package:rxbloc_list/bloc/bloc_provider.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of(context);
    return StreamBuilder(
      stream: blocProvider.menuList,
      builder: (context, snapshot) {
        return Container(
          child: Column(
            children: <Widget>[
              Text("${snapshot.data[0].name}"),
              Text("${snapshot.data[0].price}"),
              Image(
                image: NetworkImage(snapshot.data[0].image),
              )
            ],
          ),
        );
      },
    );
  }
}
