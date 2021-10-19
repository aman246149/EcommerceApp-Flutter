import 'package:ecommerce/Providers/RegistrationProvider.dart';
import 'package:ecommerce/Providers/ThemeSwitcherProvider.dart';
import 'package:ecommerce/Screens/Cart%20Screen/Cart.dart';
import 'package:ecommerce/Screens/HomePage/HomePage.dart';
import 'package:ecommerce/Screens/Login/Login.dart';
import 'package:ecommerce/Screens/ProductDetailsScreen/ProductDetails.dart';
import 'package:ecommerce/Screens/ProductScreen/ProductScreen.dart';
import 'package:ecommerce/Screens/Registration/Registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Providers/CartProvider.dart';
import './Providers/ProductDetailsScreenProvider.dart';
import 'Providers/FavouriteProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeSwitcherProvider()),
    ChangeNotifierProvider(create: (_) => productDetailsScreen()),
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
    ),
    ChangeNotifierProvider(create: (_) => FavouriteProvider()),
    ChangeNotifierProvider(create: (_) => RegistrationProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var isDark = context.watch<ThemeSwitcherProvider>().getTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: isDark == true ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/productDetails': (_) => ProductDetails(),
        '/cart': (_) => Cart(),
        '/signup': (_) => Registration(),
        '/login': (_) => Login(),
        '/': (_) => ProductScreen()
      },
    );
  }
}
