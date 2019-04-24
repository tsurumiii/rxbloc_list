import 'package:flutter/material.dart';
import 'package:rxbloc_list/bottomMenu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import './bloc/bloc_provider.dart';

class MenuDetail extends StatefulWidget {
  @override
  _MenuDetailState createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SlidingUpPanel(
        maxHeight: 500,
        minHeight: 100,
        panel: BottomMenu(),
        body: StreamBuilder(
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
        ),
      ),
    );
  }
}
