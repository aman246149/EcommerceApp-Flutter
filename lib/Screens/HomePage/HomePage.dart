import 'package:ecommerce/Screens/FavouriteScreen/FavouriteScreen.dart';
import 'package:ecommerce/Screens/ProductScreen/ProductScreen.dart';
import 'package:ecommerce/Screens/User%20Screen/UserScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    ProductScreen(),
    Favourites(),
    UserScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favourite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: "User")
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
