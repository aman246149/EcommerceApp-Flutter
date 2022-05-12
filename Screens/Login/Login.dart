import 'package:ecommerce/Screens/Login/LoginForm.dart';
import 'package:ecommerce/Screens/Registration/Registration.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
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
            LoginForm(),
            Positioned(
              top: MediaQuery.of(context).size.height / 2.2,
              child: Row(
                children: [
                  Text(
                    "New User ?",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registration(),
                            ));
                      },
                      child: Text(
                        "Register",
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
