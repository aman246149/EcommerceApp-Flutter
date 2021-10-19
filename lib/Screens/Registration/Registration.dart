

import 'package:ecommerce/Screens/Registration/RegistrationForm.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class Registration extends StatelessWidget {

  var KAppBarStyle=TextStyle(color: Colors.white,fontSize: 50);
  var KAppBarTitleStyle=TextStyle(color: Colors.white,fontSize: 20);

  var KBackButtonStyle=Colors.white;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset:true,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.network("https://images.unsplash.com/photo-1634412789413-ac718e7f1269?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60",
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(38.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.arrow_back_ios,color: KBackButtonStyle,),
                        ],
                      ),
                      SizedBox(height: 20),

                      Text("Glad To Meet You",style: KAppBarStyle,),
                      SizedBox(height: 20),

                      Text("Create Your new Account For Future Uses",style: KAppBarTitleStyle,),
                      SizedBox(height: 40),
                      RegistrationForm(),
                    ],
                  ),
                ),
              ),
            ],
          )
        ),);
  }
}
