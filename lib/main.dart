import 'package:flutter/material.dart';
import 'package:loginuicolors/Admin/admin_screen.dart';
import 'package:loginuicolors/componenets/profile.dart';
import 'package:loginuicolors/login.dart';
import 'package:loginuicolors/provider/item_provaider.dart';
import 'package:loginuicolors/provider/cart_provaider.dart';
import 'package:loginuicolors/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'componenets/search.dart';
import 'componenets/cart.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        home: HomeScreen(),
        routes: {
          'register': (context) => MyRegister(),
          'login': (context) => MyLogin(),
          'home': (context) => HomeScreen(),
          'search': (context) => HomePageSearch(),
          'cart': (context) => Cart(),
          'profile': (context) => Profile(),
          'admin': (context) => AdminScreen(),
        },
      ),
    );
  }
}
