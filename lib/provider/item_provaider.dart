import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginuicolors/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  late ProductModel productModel;
  List<ProductModel> itemsList = [];

  fatchItemsData() async {
    List<ProductModel> newList = [];

    final QuerySnapshot Items =
        await FirebaseFirestore.instance.collection("ItemsData").get();

    Items.docs.forEach((e) {
      productModel = ProductModel(
        itemId: e.get('itemId'),
        itemImage: e.get('itemImage'),
        itemName: e.get('itemName'),
        itemPrice: e.get('itemPrice'),
        itemQuantity: e.get('itemQuantity'),
      );
      newList.add(productModel);
    });
    itemsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getItemsDataList {
    return itemsList;
  }
}
