import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageItems extends StatefulWidget {
  bool? isBool = false;
  HomePageItems(
      {required this.price,
      required this.itemName,
      required this.imageLink,
      this.totalItems,
      this.onTap,
      this.onDelete,
      this.id,
      this.isBool});
  int? price;
  int? id;
  String? itemName;
  String? imageLink;
  int? totalItems;
  Function()? onTap;
  Function()? onDelete;

  @override
  State<HomePageItems> createState() => HomePageItemsState();
}

class HomePageItemsState extends State<HomePageItems> {
  Color _addToCart = Colors.blue;
  int totalItems = 1;
  // bool isBool = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void _changeCartColor() {
    setState(() {
      _addToCart =
          _addToCart == Colors.blue ? Colors.blue.shade300 : Colors.blue;
    });
  }

  // int totalPrice = 0;
  void updateCart(int? itemId, int? itemQuantity, int? price) async {
    final firebaseUser = (FirebaseAuth.instance.currentUser!).uid;

    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(firebaseUser)
        .collection('cart')
        .doc('${itemId}')
        .update({
      "itemQuantity": itemQuantity,
    });
    // totalPrice = totalPrice + itemQuantity! * price!;
  }

  // int a = total.length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 180,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: NetworkImage(widget.imageLink.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.itemName.toString(),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: <Widget>[
                      Icon(
                        Icons.star_border_outlined,
                      ),
                      Icon(
                        Icons.star_border_outlined,
                      ),
                      Icon(
                        Icons.star_border_outlined,
                      ),
                      Icon(
                        Icons.star_border_outlined,
                      ),
                      Icon(
                        Icons.star_border_outlined,
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '\$ ${(widget.price?.toInt())! * totalItems}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    widget.isBool == false
                        ? InkWell(
                            onTap: () {
                              _changeCartColor();
                            },
                            child: Container(
                              height: 30,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _addToCart,
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: widget.onTap,
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (totalItems > 0) {
                                            totalItems--;
                                          }
                                        });
                                        updateCart(widget.id, totalItems,
                                            widget.price);
                                      },
                                      icon: Icon(Icons.remove),
                                    ),
                                    Text(totalItems.toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          totalItems++;
                                        });
                                        updateCart(widget.id, totalItems,
                                            widget.price);
                                      },
                                      icon: Icon(Icons.add),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: widget.onDelete,
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
