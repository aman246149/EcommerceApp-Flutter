import 'package:ecommerce/Providers/ThemeSwitcherProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, ('/signup'));
                    },
                    child: Text(
                      "Sign Up or LogIn",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      context.read<ThemeSwitcherProvider>().setTheme();
                    },
                    child: Text(
                      "Dark Theme",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              RaisedButton(
                color: Colors.redAccent,
                onPressed: () {},
                child: Text(
                  "Your Order",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Center(
                child: Text(
                  "This app is made by flutter if you want to contribute in this project you can go to my github rep <aman246149>",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
