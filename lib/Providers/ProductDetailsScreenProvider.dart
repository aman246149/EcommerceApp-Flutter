import 'package:flutter/material.dart';

class productDetailsScreen extends ChangeNotifier {
  late int? id;
  late String? title;
  late String? price;
  late String? description;
  late String? category;
  late String? imageurl;
  late String? rating;
  late int qty;

  productDetailsScreen(
      [this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.imageurl,
      this.rating,
      this.qty = 1]);

  void setData(int id, String title, String price, String description,
      String category, String imageurl, String rating) {
    this.id = id == null ? 0 : id;
    this.title = title;
    this.price = price;
    this.description = description;
    this.category = category;
    this.imageurl = imageurl;
    this.rating = rating;
    notifyListeners();
  }
}
