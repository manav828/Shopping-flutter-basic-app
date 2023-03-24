// import 'dart:js';
import 'componenets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginuicolors/componenets/cart.dart';
import 'package:loginuicolors/items/homeDesign.dart';
import 'package:loginuicolors/provider/item_provaider.dart';
import 'package:provider/provider.dart';
import 'componenets/profile.dart';
import 'componenets/search.dart';
import 'items/home_items.dart';
import 'componenets/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  var _pageData = [HomeDesign(), HomePageSearch(), Cart(), Profile()];
  @override
  // void initState() {
  //   super.initState();
  //   productProvider = Provider.of<ProductProvider>(context, listen: false);
  //   productProvider?.fatchItemsData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffcbcbcb),
      body: Container(
        child: _pageData[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.blue,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
      ),
//Center
    );
  }
}
//BoxDecoration
