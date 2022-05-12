import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Components/CommonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../Providers/ProductDetailsScreenProvider.dart';

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
    if (mounted) {
      setState(() {
        productsList = jsonResponse;
      });
    }

    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["productImageUrl"].runtimeType);
        var productMap = {
          'description': doc["productDescription"].toString(),
          'image': doc["productImageUrl"].toString(),
          'title': doc["productName"].toString(),
          'price': doc["productPrice"].toString(),
          'rating': doc["productRating"]
        };
        print(productMap.length);
        setState(() {
          productsList.add(productMap);
        });
        print(productsList[productsList.length - 1]);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchProductList();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fetchProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //right now only admin can add products this funcitioality i will add later
          Navigator.pushNamed(context, '/addproduct');
        },
        child: Icon(
          Icons.add,
          size: 25,
        ),
      ),
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
