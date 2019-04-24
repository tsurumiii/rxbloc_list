import 'package:flutter/material.dart';
import 'package:rxbloc_list/cart/cart_bloc.dart';
import './model/cart_item.dart';
import './cart/cart_provider.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    final cart = CartProvider.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('カート一覧'),
      ),
      body: StreamBuilder<List<CartItem>>(
          stream: cart.items,
          builder: (context, snapshot) {
            print(snapshot.data.length);
            return ListView(
              children: snapshot.data.map((item) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: height * 0.2,
                              width: width * 0.3,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(item.menuItem.image))),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              height: height * 0.15,
                              width: width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(item.menuItem.name),
                                  Text('${item.menuItem.price}円'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('数量: ${item.count}'),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: height * 0.04,
                                              child: FloatingActionButton(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.black,
                                                elevation: 2,
                                                heroTag: null,
                                                child: Icon(
                                                  Icons.minimize,
                                                  size: 10,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  final menuItem =
                                                      item.menuItem;

                                                  CartProvider.of(context)
                                                      .cartRemove
                                                      .add(CartAddtion(
                                                          menuItem));
                                                },
                                              ),
                                            ),
                                            Container(
                                              height: height * 0.04,
                                              child: FloatingActionButton(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.black,
                                                elevation: 2,
                                                heroTag: null,
                                                child: Icon(
                                                  Icons.plus_one,
                                                  size: 10,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  final menuItem =
                                                      item.menuItem;
                                                  CartProvider.of(context)
                                                      .cartAddtion
                                                      .add(CartAddtion(
                                                          menuItem));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: width,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Text('小計'),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                  '${(item.menuItem.price * item.count)}円'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}

Widget ItemCard(BuildContext context, CartItem item) {
  @override
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Card(
    child: Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Container(
                height: height * 0.2,
                width: width * 0.3,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(item.menuItem.image))),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                height: height * 0.15,
                width: width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(item.menuItem.name),
                    Text('${item.menuItem.price}円'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('数量: ${item.count}'),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: height * 0.04,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 2,
                                  heroTag: null,
                                  child: Icon(
                                    Icons.minimize,
                                    size: 10,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    final menuItem = item.menuItem;
                                    CartProvider.of(context)
                                        .cartRemove
                                        .add(CartAddtion(menuItem));
                                  },
                                ),
                              ),
                              Container(
                                height: height * 0.04,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 2,
                                  heroTag: null,
                                  child: Icon(
                                    Icons.plus_one,
                                    size: 10,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    final menuItem = item.menuItem;
                                    CartProvider.of(context)
                                        .cartAddtion
                                        .add(CartAddtion(menuItem));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: width,
          color: Colors.grey,
        ),
        Container(
          margin: EdgeInsets.all(15),
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text('小計'),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text('${(item.menuItem.price * item.count)}円'),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
