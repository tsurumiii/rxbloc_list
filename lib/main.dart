import 'package:flutter/material.dart';
import './bloc/bloc_provider.dart';
import './bloc/menu_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('rx Bloc List'),
      ),
      body: ListView(
        children: <Widget>[
          _menuList(context),
          _menuBloc(context),
        ],
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
            BlocProvider.of(context)
                .addname
                .add(MenuNameAdd(_menus[index]['menu_name']));
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
    return StreamBuilder(
      stream: blocProvider.getMenuName,
      initialData: 'menu name',
      builder: (context, snapshot) {
        return Container(
          child: Text(snapshot.data),
        );
      },
    );
  }
}
