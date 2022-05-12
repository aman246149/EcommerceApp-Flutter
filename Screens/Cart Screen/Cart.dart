import 'package:ecommerce/Providers/FavouriteProvider.dart';
import 'package:ecommerce/Providers/ProductDetailsScreenProvider.dart';
import 'package:ecommerce/Screens/CheckOut/CheckOut.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/CartProvider.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var id = context.watch<productDetailsScreen>().id;
    var title = context.watch<productDetailsScreen>().title;
    var price = context.watch<productDetailsScreen>().price;
    var description = context.watch<productDetailsScreen>().description;
    var category = context.watch<productDetailsScreen>().category;
    var image = context.watch<productDetailsScreen>().imageurl;
    var ratingg = context.watch<productDetailsScreen>().rating;
    var cartList = context.watch<CartProvider>().cart;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Color(0xFFFFD819),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 38.0, top: 40),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Cart",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total ${cartList.length == 0 ? 0 : context.watch<CartProvider>().totalPrice}",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckOut(
                              price: context.watch<CartProvider>().totalPrice,
                              title: title,
                            ),
                          ));
                    },
                    child: Text(
                      "PLACE ORDER",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: cartList.length == 0
                    ? Center(
                        child: Text(
                          "No Element In the Cart",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 180,
                                        width: 180,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Image.network(
                                          cartList[index].imageurl.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18.0, right: 10),
                                        child: Container(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cartList[index]
                                                      .title
                                                      .toString()
                                                      .split(" ")[0],
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  CartProvider>()
                                                              .increaseQty(
                                                                  cartList[
                                                                          index]
                                                                      .id);
                                                        },
                                                        icon: Icon(Icons.add)),
                                                    Text(
                                                      "QTY : ${cartList[index].qty} ",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          print("press");
                                                          context
                                                              .read<
                                                                  CartProvider>()
                                                              .decreaseQty(
                                                                  cartList[
                                                                          index]
                                                                      .id);
                                                        },
                                                        icon:
                                                            Icon(Icons.remove)),
                                                  ],
                                                ),
                                                Text(
                                                    "${cartList[index].price.toString().split(".")[0]} Rs",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("30 Days Easy Return",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              context
                                                  .read<CartProvider>()
                                                  .removeItem(index);
                                            },
                                            child: Text(
                                              "Remove",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        InkWell(
                                          onTap: () {
                                            productDetailsScreen item =
                                                new productDetailsScreen(
                                                    id,
                                                    title,
                                                    price,
                                                    description,
                                                    category,
                                                    image,
                                                    ratingg);
                                            context
                                                .read<FavouriteProvider>()
                                                .addToFavourite(item);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Succssfully Added in your Favourites')),
                                            );
                                          },
                                          child: Text(
                                            "MOVE TO WHISHLIST",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
