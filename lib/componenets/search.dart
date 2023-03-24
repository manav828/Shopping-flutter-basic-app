import 'package:flutter/material.dart';
import 'package:loginuicolors/componenets/cart.dart';
import 'package:loginuicolors/items/homeDesign.dart';
import '../items/home_items.dart';
import 'package:loginuicolors/models/product_model.dart';
import 'package:loginuicolors/provider/item_provaider.dart';
import 'package:provider/provider.dart';

import '../provider/item_provaider.dart';

class HomePageSearch extends StatefulWidget {
  @override
  State<HomePageSearch> createState() => _HomePageSearchState();
}

class _HomePageSearchState extends State<HomePageSearch> {
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchItemsData();
    // print("::::::::::::::::");

    super.initState();
  }

  String name = "";
  ProductProvider? productProvider;
  late List<ProductModel>? search =
      List.from(productProvider!.getItemsDataList);

  void searchItem(String name) {
    setState(() {
      search = productProvider?.getItemsDataList
          .where((element) =>
              element.itemName!.toLowerCase().contains(name.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Search"),
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
              onChanged: (value) => searchItem(value),
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
          SizedBox(
            height: 20,
          ),
          Column(
            children: search!.map((e) {
              return HomePageItems(
                onTap: () {
                  // print(index);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(
                        itemId: e.itemId,
                        itemPrice: e.itemPrice,
                        itemName: e.itemName,
                        itemImage: e.itemImage,
                      ),
                    ),
                  );
                },
                price: e.itemPrice,
                itemName: e.itemName,
                imageLink: e.itemImage,
                isBool: false,
              );
            }).toList(),
          ),
          // Expanded(
          //     child: ListView.builder(
          //   itemCount: search?.length,
          //   itemBuilder: (context, index) => ListTile(
          //     title: HomePageItems(
          //       price: search?[index].itemPrice,
          //       itemName: search?[index].itemName,
          //       imageLink: search?[index].itemImage,
          //       isBool: false,
          //     ),
          //   ),
          // ))
          // HomePageItems(
          //   price: 40,
          //   itemName: ' My name Is Manav',
          //   isBool: false,
          // ),
        ]));
    // bottomNavigationBar: BottomNavigation());
  }
}
