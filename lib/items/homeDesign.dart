import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginuicolors/models/cart_model.dart';
import 'package:loginuicolors/provider/item_provaider.dart';
import 'package:loginuicolors/provider/cart_provaider.dart';
import 'package:loginuicolors/register.dart';
import 'package:provider/provider.dart';
import '../componenets/cart.dart';
import 'home_items.dart';
import '../componenets/bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User loggedinUser;

class HomeDesign extends StatefulWidget {
  HomeDesign({this.userName, this.phoneNumber});
  final String? userName;
  final String? phoneNumber;
  @override
  State<HomeDesign> createState() => _HomeDesignState();
}

class _HomeDesignState extends State<HomeDesign> {
  final _auth = FirebaseAuth.instance;
  Color _addToCart = Colors.blue;
  String? userName;
  int? phoneNumber;
  String? name;
  String? Role;
  String? AgentName;

  // String? itemImage;
  // String? itemName;
  // int? itemPrice;

  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchItemsData();
    super.initState();
    getCurrentUser();
    // fechdata();
  }

  // void fechdata() async {
  //   await FirebaseFirestore.instance
  //       .collection('Admin')
  //       .doc('Admin_1')
  //       .collection('Agent')
  //       .doc('Agent_1')
  //       .get()
  //       .then((ds) {
  //     AgentName = ds.get('Name');
  //     Role = ds.get('Role');
  //   }).catchError((e) {
  //     print(e);
  //   });
  //   print(AgentName);
  //   print(Role);
  // }

  String? itemName;
  String? itemImage;
  int? itemPrice;
  int? itemId;
  int cartCount = 0;

  void setDataOfCart(String? itemName, String? itemImage, int? itemPrice,
      int? itemId, int? itemQuantity, int? totalCart) async {
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;

    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(firebaseUser)
        .collection('cart')
        .doc('${itemId}')
        .set({
      "itemName": itemName,
      "itemImage": itemImage,
      "itemPrice": itemPrice,
      "itemId": itemId,
      "itemQuantity": itemQuantity,
      "totalPrice": totalCart,
    });
  }

  void _changeCartColor() {
    setState(() {
      _addToCart =
          _addToCart == Colors.blue ? Colors.blue.shade300 : Colors.blue;
    });
  }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  ProductProvider? productProvider;
  List<int> cartItemId = [];

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () {
                Navigator.pushNamed(context, 'search');
              }),
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);

                //Implement logout functionality
              }),
        ],
        title: Text('Home Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder(
              future: _fetch(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return UserAccountsDrawerHeader(
                  accountName: Text(userName.toString()),
                  accountEmail: Text(phoneNumber.toString()),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/img.png',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                  ),
                );
              },
              // child:
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Friends'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Request'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Policies'),
              onTap: () => null,
            ),
            Divider(),
            ListTile(
              title: Text('Exit'),
              leading: Icon(Icons.exit_to_app),
              onTap: () => null,
            ),
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  ClipRect(
                    child: Container(
                      height: 150,
                      width: 500,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-RTjCAmTTJ1I2EwRzl5I_Jwj2_ZjqW5gfSA&usqp=CAU'),
                          fit: BoxFit.cover,
                        ), //DecorationImage
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ), //Border.all
                        borderRadius: BorderRadius.circular(10),
                      ),
                      //Padding
                      //Container
                    ), //Banner
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Items'),
                        Text('View All'),
                      ],
                    ),
                  ),

                  Column(
                    children: productProvider!.getItemsDataList.map((e) {
                      int index = productProvider!.getItemsDataList.indexOf(e);
                      return HomePageItems(
                        onTap: () {
                          print(index);

                          Cart(
                            itemId: e.itemId,
                            itemPrice: e.itemPrice,
                            itemName: e.itemName,
                            itemImage: e.itemImage,
                            itemQuantity: e.itemQuantity,
                          );

                          if (cartItemId.contains(e.itemId)) {
                            print('::::::::::::alrady exist');
                          } else {
                            int? num = e.itemPrice;
                            setDataOfCart(
                                e.itemName,
                                e.itemImage,
                                e.itemPrice,
                                e.itemId,
                                e.itemQuantity,
                                e.itemQuantity! * num!);

                            int? data = e.itemId;
                            cartItemId.add(data!);
                            print(cartItemId);
                          }

                          //   ),
                          // );
                        },
                        id: e.itemId,
                        price: e.itemPrice,
                        itemName: e.itemName,
                        imageLink: e.itemImage,
                        isBool: false,
                      );
                    }).toList(),
                  ),
                  // HomePageItems(
                  //   price: 40,
                  //   itemName: 'hii',
                  //   imageLink:
                  //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRLMDGjV2SwGOELJKsIYleHKkmpWm3RI3yUw&usqp=CAU',
                  //   isBool: false,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(firebaseUser)
          .get()
          .then((ds) {
        userName = ds.get('displayName');
        phoneNumber = ds.get('phone');
      }).catchError((e) {
        print(e);
      });
    }
  }

  void cartData() async {
    await FirebaseFirestore.instance
        .collection('Admin')
        .doc('Admin_1')
        .collection('Agent')
        .doc('Agent_1')
        .collection('Distributor')
        .doc('Distributor_1')
        .collection('cart')
        .doc('cart_$cartCount')
        .get()
        .then((data) {
      print(data.id);
    });
  }
}
