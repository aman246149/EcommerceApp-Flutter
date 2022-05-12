import 'package:ecommerce/Screens/Login/Login.dart';
import 'package:ecommerce/Screens/Registration/RegistrationForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Registration extends StatelessWidget {
  var KAppBarStyle = TextStyle(color: Colors.white, fontSize: 50);
  var KAppBarTitleStyle = TextStyle(color: Colors.white, fontSize: 20);

  var KBackButtonStyle = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Register"),
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: true,
          body: Stack(
            alignment: Alignment.center,
            children: [
              RegistrationForm(),
              Positioned(
                top: MediaQuery.of(context).size.height / 1.4,
                child: Row(
                  children: [
                    Text(
                      "Already a user ?",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ));
                        },
                        child: Text(
                          "LogIn",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ))
                  ],
                ),
              )
            ],
          ),
          ),
    );
  }
}
