import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginuicolors/models/cart_model.dart';
import 'package:loginuicolors/models/product_model.dart';

class CartProvider with ChangeNotifier {
  late CartModel cartModel;
  List<CartModel> itemsList = [];

  fatchItemsData() async {
    List<CartModel> newList = [];
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;

    final QuerySnapshot Items = await FirebaseFirestore.instance
        .collection('UserData')
        .doc(firebaseUser)
        .collection('cart')
        .get();

    Items.docs.forEach((e) {
      cartModel = CartModel(
        itemId: e.get('itemId'),
        itemImage: e.get('itemImage'),
        itemName: e.get('itemName'),
        itemPrice: e.get('itemPrice'),
      );
      newList.add(cartModel);
    });
    itemsList = newList;
    notifyListeners();
  }

  List<CartModel> get getItemsDataList {
    return itemsList;
  }
}
