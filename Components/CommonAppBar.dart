import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/CartProvider.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 40,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey.shade200),
            child: TextField(
              onChanged: (value) => print(value),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: (20), vertical: (9)),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Search product",
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Stack(
              children: [
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, '/cart');
                }, icon: Icon(Icons.shopping_cart)),
                Text(context.watch<CartProvider>().cart.length.toString(),style: TextStyle(fontWeight: FontWeight.w900),)
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(Icons.notifications_active_outlined),
          )
        ],
      ),
    );
  }
}
