import 'dart:convert';
import 'package:ecommerce/Components/CommonAppBar.dart';
import 'package:ecommerce/Providers/CartProvider.dart';

import '../../Providers/ProductDetailsScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<dynamic> productsList = [];

  void fetchProductList() async {
    var client = http.Client();
    var url = Uri.parse("https://fakestoreapi.com/products");
    var data = await client.get(url);
    var response = await data.body;
    var jsonResponse = jsonDecode(response);
    setState(() {
      productsList = jsonResponse;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: productsList.length == 0
                  ? Center(
                      child: Text(
                        "Loading...",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 1 / 1.5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: productsList.length,
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: () {
                            var rate = productsList[index]["rating"]["rate"]
                                .toString();
                            var arr = rate.split('.');

                            context.read<productDetailsScreen>().setData(
                                productsList[index]["id"],
                                productsList[index]["title"],
                                productsList[index]["price"].toString(),
                                productsList[index]["description"],
                                productsList[index]["category"],
                                productsList[index]["image"],
                                arr[0]);
                            Navigator.pushNamed(context, '/productDetails');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                // color: Colors.yellow,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: Image.network(
                                      productsList[index]["image"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Price: ${productsList[index]["price"].toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    productsList[index]["title"],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ),
        ],
      ),
    );
  }
}
