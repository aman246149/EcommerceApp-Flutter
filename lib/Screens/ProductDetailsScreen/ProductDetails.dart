import 'package:ecommerce/Components/CircularColor.dart';
import 'package:ecommerce/Components/RatingStar.dart';
import 'package:ecommerce/Components/SizeContainer.dart';
import 'package:ecommerce/Screens/Cart%20Screen/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/ProductDetailsScreenProvider.dart';
import '../../Providers/CartProvider.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var id = context.watch<productDetailsScreen>().id;
    var title = context.watch<productDetailsScreen>().title;
    var price = context.watch<productDetailsScreen>().price;
    var description = context.watch<productDetailsScreen>().description;
    var category = context.watch<productDetailsScreen>().category;
    var image = context.watch<productDetailsScreen>().imageurl;
    var ratingg = context.watch<productDetailsScreen>().rating;

    print(int.parse(ratingg!).runtimeType);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [

            Container(
                height: MediaQuery.of(context).size.height / 2.5,
                color: Colors.yellow,
                child: Center(
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              title!,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w800),
                            ),
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Icon(
                              Icons.favorite,
                              size: 35.0,
                              color: Colors.orange,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ),
                        ],
                      ),
                      int.parse(ratingg) == 1
                          ? Row(
                              children: [
                                RatingStar(),
                              ],
                            )
                          : int.parse(ratingg) == 2
                              ? Row(
                                  children: [RatingStar(), RatingStar()],
                                )
                              : int.parse(ratingg) == 3
                                  ? Row(
                                      children: [
                                        RatingStar(),
                                        RatingStar(),
                                        RatingStar()
                                      ],
                                    )
                                  : int.parse(ratingg) == 4
                                      ? Row(
                                          children: [
                                            RatingStar(),
                                            RatingStar(),
                                            RatingStar(),
                                            RatingStar()
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            RatingStar(),
                                            RatingStar(),
                                            RatingStar(),
                                            RatingStar(),
                                            RatingStar()
                                          ],
                                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Color",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircularColor(
                                      colorName: Colors.grey,
                                    ),
                                    CircularColor(
                                      colorName: Colors.red,
                                    ),
                                    CircularColor(
                                      colorName: Colors.orange,
                                    ),
                                    CircularColor(
                                      colorName: Colors.blue,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Size",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizeContainer(sizeName: "S"),
                                    SizeContainer(sizeName: "M"),
                                    SizeContainer(sizeName: "L"),
                                    SizeContainer(sizeName: "XL"),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Price : ${price} Rs",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Product Description",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        description!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        onPressed: () {
                          productDetailsScreen item=new productDetailsScreen(id,title,price,description,category,image,ratingg);
                          Navigator.pushNamed(context, '/cart');
                          context.read<CartProvider>().addToCart(item);
                        },
                        child: Text(
                          "ADD TO CART",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios),),),
          ],
        ),
      ),
    );
  }
}
