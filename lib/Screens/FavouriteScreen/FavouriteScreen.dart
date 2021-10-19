
import 'package:ecommerce/Components/CommonAppBar.dart';
import 'package:ecommerce/Providers/ProductDetailsScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import "../../Providers/FavouriteProvider.dart";

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favouriteCart = context.watch<FavouriteProvider>().Favouritescart;
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(),
          Expanded(
            child: favouriteCart.length == 0
                ? Center(
                    child: Text("No Items In Favourite",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  )
                : ListView.builder(
                    itemCount: favouriteCart.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            var rate= favouriteCart[index].rating.toString();
                            var arr=rate.split('.');

                            context.read<productDetailsScreen>().setData(
                                favouriteCart[index].id!,
                                favouriteCart[index].title!,
                                favouriteCart[index].price!,
                                favouriteCart[index].description!,
                                favouriteCart[index].category!,
                                favouriteCart[index].imageurl!,
                                arr[0]
                            );
                            Navigator.pushNamed(context, '/productDetails');
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: Image.network(favouriteCart[index].imageurl.toString(),fit: BoxFit.cover,),
                            ),
                            title: Text(favouriteCart[index].title.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                            trailing: Text("${favouriteCart[index].price.toString()} Rs",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
