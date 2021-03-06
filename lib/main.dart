import 'package:flutter/material.dart';
import './cartList.dart';
import './cart/cart_bloc.dart';
import './bottomMenu.dart';
import './cart/cart_provider.dart';
import './detail.dart';
import './List_bloc/menu.dart';
import './bloc/bloc_provider.dart';
import './bloc/menu_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import './model/menu_item.dart';
import './widget/cart_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: CartProvider(
        cartBloc: CartBloc(),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final cartBloc = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('rx Bloc List'),
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
        body: ListView(
          children: <Widget>[
            _menuList(context),
            _menuBloc(context),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _menus = [
    {
      "menu_name": "豚骨ラーメン",
      "price": 800,
      "menu_img": "https://www.fukuya.com/upload/save_image/i0911_1.jpg"
    },
    {
      "menu_name": "醤油ラーメン",
      "price": 1000,
      "menu_img":
          "https://upload.wikimedia.org/wikipedia/ja/f/fc/Soy_ramen.jpg",
    },
    {
      "menu_name": "塩ラーメン",
      "price": 900,
      "menu_img":
          "https://media.timeout.com/images/102837746/1024/576/image.jpg",
    },
  ];

  Widget _menuList(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: _menus.length,
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            print(_menus[index]['menu_name']);
            print(_menus[index]['price']);
            BlocProvider.of(context).addname.add(MenuItem(
                _menus[index]['menu_name'],
                _menus[index]['price'],
                _menus[index]['menu_img']));
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) => MenuDetail()));
          },
          child: Container(
            width: width * 0.85,
            height: height * 0.2,
            margin: EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
            child: Row(
              children: <Widget>[
                Container(
                  width: width * 0.4,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_menus[index]["menu_img"]),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.45,
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(_menus[index]['menu_name']),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text("${_menus[index]['price']}"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _menuBloc(BuildContext context) {
    final blocProvider = BlocProvider.of(context);
    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: blocProvider.getMenuName,
          initialData: 'menu name',
          builder: (context, snapshot) {
            // print('snapshot.data : ${snapshot.data}');
            if (snapshot.data == []) {
              return Container();
            }
            return Container(
              child: Column(
                children: <Widget>[
                  Text("${snapshot.data[0]}"),
                  Text("${snapshot.data[1]}"),
                  Image(
                    image: NetworkImage(snapshot.data[2]),
                  )
                ],
              ),
            );
          },
        ),
        StreamBuilder(
          stream: blocProvider.menuList,
          initialData: 'menu name',
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            }
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
      ],
    );
  }
}
