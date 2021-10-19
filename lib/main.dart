import 'package:ecommerce/Providers/ThemeSwitcherProvider.dart';
import 'package:ecommerce/Screens/Cart%20Screen/Cart.dart';
import 'package:ecommerce/Screens/HomePage/HomePage.dart';
import 'package:ecommerce/Screens/ProductDetailsScreen/ProductDetails.dart';
import './Providers/ProductDetailsScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Providers/CartProvider.dart';
import 'Providers/FavouriteProvider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeSwitcherProvider()),
    ChangeNotifierProvider(create: (_) => productDetailsScreen()),
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
    ),
    ChangeNotifierProvider(create: (_) => FavouriteProvider()),
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
        '/cart': (_) => Cart()
      },
    );
  }
}
