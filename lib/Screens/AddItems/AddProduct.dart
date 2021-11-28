import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productRating = TextEditingController();
  TextEditingController productImageUrl = TextEditingController();

  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  void addTheProduct() {
    products
        .add({
          'productName': productName.text.toString().trim(),
          'productPrice': productPrice.text.toString().trim(),
          'productDescription': productDescription.text.toString().trim(),
          'productRating': {"rate": productRating.text.toString().trim()},
          'productImageUrl': productImageUrl.text.toString().trim()
        })
        .then((value) => print("Product added successfully ${value}"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            TextField(
              controller: productName,
              decoration: InputDecoration(
                hintText: 'Product Name',
              ),
            ),
            TextField(
              controller: productPrice,
              decoration: InputDecoration(
                hintText: 'Product price',
              ),
            ),
            TextField(
              controller: productDescription,
              decoration: InputDecoration(
                hintText: 'Product Description',
              ),
            ),
            TextField(
              controller: productRating,
              decoration: InputDecoration(
                hintText: 'Product Rating',
              ),
            ),
            TextField(
              controller: productImageUrl,
              decoration: InputDecoration(
                hintText: 'Product Image Url',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  addTheProduct();
                },
                child: Text(
                  "Add The Product",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
