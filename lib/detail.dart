import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxbloc_list/bottomMenu.dart';
import 'package:rxbloc_list/cart/cart_bloc.dart';
import 'package:rxbloc_list/cart/cart_provider.dart';
import 'package:rxbloc_list/cartList.dart';
import 'package:rxbloc_list/widget/cart_button.dart';
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
    final cartBloc = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          StreamBuilder<int>(
            stream: cartBloc.itemCount,
            initialData: cartBloc.itemCount.value,
            builder: (context, snapshot) {
              return CartButton(
                itemCount: snapshot.data,
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => CartList()));
                },
              );
            },
          )
        ],
      ),
      body: SlidingUpPanel(
        maxHeight: 500,
        minHeight: 100,
        panel: BottomMenu(),
        body: StreamBuilder(
          stream: blocProvider.menuList,
          builder: (context, snapshot) {
            if (snapshot.data == []) {
              return Container();
            }
            return Container(
              child: Column(
                children: <Widget>[
                  Text("${snapshot.data[0].name}"),
                  Text("${snapshot.data[0].price}"),
                  Image(
                    image: NetworkImage(snapshot.data[0].image),
                  ),
                  Container(
                    width: 200,
                    child: FlatButton(
                      color: Colors.amber,
                      child: Text('カートに追加'),
                      onPressed: () {
                        final menuItem = snapshot.data[0];
                        CartProvider.of(context)
                            .cartAddtion
                            .add(CartAddtion(menuItem));
                        // Navigator.of(context).pop();
                      },
                    ),
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
