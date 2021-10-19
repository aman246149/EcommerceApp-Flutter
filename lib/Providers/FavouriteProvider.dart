import './ProductDetailsScreenProvider.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier{
  List<productDetailsScreen> Favouritescart = [];

  void addToFavourite(item){

    for(int i=0;i<Favouritescart.length;i++){
      if(item.id==Favouritescart[i].id){
        return;
      }
    }

    Favouritescart.add(item);
    print("item added");
    print(item.rating);
    notifyListeners();
  }

  void removeFromFavourite(int index){
    Favouritescart.removeAt(index);
    notifyListeners();
  }

}