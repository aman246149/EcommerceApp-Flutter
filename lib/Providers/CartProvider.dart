import 'package:flutter/material.dart';
import './ProductDetailsScreenProvider.dart';

class CartProvider extends ChangeNotifier {
  List<productDetailsScreen> cart = [];
  int totalPrice = 0;

  void addToCart(var item) {
    bool itemExist=false;
    if (cart.length == 0) {
      totalPrice=0;
      cart.add(item);
      calculatePrice();
      return;
    }
    for (int i = 0; i < cart.length; i++) {
      if (item.id == cart[i].id) {
        increaseQty(item.id);
        itemExist=true;
        return;
      }
    }
    cart.add(item);
    if(!itemExist)
      calculatePrice();
  }

  void increaseQty(var id) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id == id) {
        cart[i].qty += 1;
      }
    }
    calculatePrice();
    notifyListeners();
  }

  void decreaseQty(var id) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id == id) {
        if (cart[i].qty <= 1) return;
        cart[i].qty -= 1;
      }
    }
    decreasePrice();
    notifyListeners();
  }

  void calculatePrice() {
    totalPrice=0;
    int localprice = 0;
    for (int i = 0; i < cart.length; i++) {
      int quantity = cart[i].qty;
      var price = cart[i].price.toString().split(".");
      int integerPrice = int.parse(price[0]);
      localprice += integerPrice * quantity;
    }
    totalPrice = localprice;
    notifyListeners();
  }

  void decreasePrice() {
    calculatePrice();
    notifyListeners();
  }

  void removeItem(var id) {
    decreaseQty(cart[id].id);
    cart.removeAt(id);
    calculatePrice();
    notifyListeners();
  }
}
