import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../items/home_items.dart';
import '../provider/cart_provaider.dart';
import '../provider/item_provaider.dart';
import 'bottom_navigation.dart';
import '../items/home_items.dart';

class Cart extends StatefulWidget {
  Cart(
      {this.itemName,
      this.itemId,
      this.itemImage,
      this.itemPrice,
      this.listOfCartItems,
      this.totalItemPrice,
      this.itemQuantity});
  String? itemName;
  String? itemImage;
  int? itemPrice;
  int? itemId;
  int? itemQuantity;
  List<int>? listOfCartItems;
  List<int>? totalItemPrice;
  @override
  State<Cart> createState() => CartState();
}

class CartState extends State<Cart> {
  int countCart = 0;

  void initState() {
    CartProvider cartProvider = Provider.of(context, listen: false);
    cartProvider.fatchItemsData();
    // totalPrice();
    super.initState();
    // getCurrentUser();
  }

  ProductProvider? productProvider;
  CartProvider? cartProvider;
  int sum = 0;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Page"),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.menu),
          )
        ],
      ),
      body: ListView(children: [
        // ListTile(
        // title: Text("Items"),
        // ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 52,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            // onChanged: (value) {
            // setState(() {
            // // query = value;
            // });
            // },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              fillColor: Color(0xffc2c2c2),
              filled: true,
              hintText: "Search for items in the store",
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Column(
          children: cartProvider!.getItemsDataList.map((e) {
            int index = cartProvider!.getItemsDataList.indexOf(e);

            // sum = sum + ((e.itemQuantity)! * (e.itemPrice)!);
            return HomePageItems(
              id: e.itemId,
              price: e.itemPrice,
              itemName: e.itemName,
              imageLink: e.itemImage,
              totalItems: e.itemQuantity,
              isBool: true,
              onDelete: () {
                setState(() async {
                  final firebaseUser =
                      (await FirebaseAuth.instance.currentUser!).uid;

                  await FirebaseFirestore.instance
                      .collection('UserData')
                      .doc(firebaseUser)
                      .collection('cart')
                      .doc('${e.itemId}')
                      .delete();
                });
              },
            );
          }).toList(),
        ),
        // HomePageItems(
        //   price: widget.itemPrice,
        //   imageLink: widget.itemImage,
        //   itemName: widget.itemName,
        //   isBool: true,
        // ),
        // HomePageItems(
        //   price: 40,
        //   itemName: ' My name Is Manav',
        //   isBool: true,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Column(
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                  ),
                ),
                Text(
                  '\$ 0',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )),
            Expanded(
                child: MaterialButton(
              child: Text('Buy'),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {},
            ))
          ],
        )
      ]),
      // bottomNavigationBar: BottomNavigation(),
    );
  }
}
