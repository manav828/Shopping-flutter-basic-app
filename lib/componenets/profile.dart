// import 'package:flutter/material.dart';
// import 'bottom_navigation.dart';
//
// class Profile extends StatelessWidget {
//   const Profile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('profile'),
//       ),
//     );
//     // bottomNavigationBar: BottomNavigation());
//   }
// }

import 'package:flutter/material.dart';
import 'package:loginuicolors/provider/userProvaider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserProvaider? user;
  String? userName;
  int? phoneNumber;
  String? email;
  String? Area;
  String? shopName;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: user?.fetch(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Container(
            child: new Stack(
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(colors: [
                    const Color(0xFF020024),
                    const Color(0xFF096079),
                    const Color(0xFF00d4ff),
                  ], begin: Alignment.topCenter, end: Alignment.center)),
                ),
                FutureBuilder(
                    future: _fetch(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: new Container(
                          child: new Stack(
                            children: <Widget>[
                              new Align(
                                alignment: Alignment.center,
                                child: new Padding(
                                  padding:
                                      new EdgeInsets.only(top: _height / 15),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new CircleAvatar(
                                        backgroundImage:
                                            new AssetImage('assets/img.png'),
                                        radius: _height / 10,
                                      ),
                                      new SizedBox(
                                        height: _height / 30,
                                      ),
                                      new Text(
                                        userName.toString(),
                                        style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              new Padding(
                                padding:
                                    new EdgeInsets.only(top: _height / 2.2),
                                child: new Container(
                                  color: Colors.white,
                                ),
                              ),
                              new Padding(
                                padding: new EdgeInsets.only(
                                    top: _height / 2.6,
                                    left: _width / 20,
                                    right: _width / 30),
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            new BoxShadow(
                                                color: Colors.black45,
                                                blurRadius: 2.0,
                                                offset: new Offset(0.0, 2.0))
                                          ]),
                                      // child: new Padding(
                                      //   padding:
                                      //       new EdgeInsets.all(_width / 20),
                                      //   // child: new Row(
                                      //   //     mainAxisAlignment: MainAxisAlignment.center,
                                      //   //     children: <Widget>[
                                      //   //       headerChild('Photos', 114),
                                      //   //       headerChild('Followers', 1205),
                                      //   //       headerChild('Following', 360),
                                      //   //     ]),
                                      // ),
                                    ),
                                    SizedBox(
                                      height: 55,
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.only(
                                          top: _height / 20),
                                      child: new Column(
                                        children: <Widget>[
                                          infoChild(_width, Icons.email,
                                              email.toString()),
                                          infoChild(_width, Icons.call,
                                              phoneNumber.toString()),
                                          infoChild(_width, Icons.location_city,
                                              Area),
                                          infoChild(
                                              _width, Icons.house, shopName),
                                          new Padding(
                                            padding: new EdgeInsets.only(
                                                top: _height / 30),
                                            child: new Container(
                                              width: _width / 3,
                                              height: _height / 20,
                                              decoration: new BoxDecoration(
                                                  color:
                                                      const Color(0xFF00d4ff),
                                                  borderRadius:
                                                      new BorderRadius.all(
                                                          new Radius.circular(
                                                              _height / 40)),
                                                  boxShadow: [
                                                    new BoxShadow(
                                                        color: Colors.black87,
                                                        blurRadius: 2.0,
                                                        offset: new Offset(
                                                            0.0, 1.0))
                                                  ]),
                                              child: new Center(
                                                child: new Text('SHOW ORDER',
                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          );
        });
  }

  Widget headerChild(String header, int value) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(header),
          new SizedBox(
            height: 8.0,
          ),
          new Text(
            '$value',
            style: new TextStyle(
                fontSize: 14.0,
                color: const Color(0xFF26CBE6),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[
              new SizedBox(
                width: width / 10,
              ),
              new Icon(
                icon,
                color: const Color(0xFF26CBE6),
                size: 36.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );

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
        email = ds.get('email');
        Area = ds.get('Area');
        shopName = ds.get('shopName');
      }).catchError((e) {
        print(e);
      });
    }
  }
}
