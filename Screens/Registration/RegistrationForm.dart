// ignore_for_file: non_constant_identifier_names

import 'package:ecommerce/Providers/RegistrationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final KbuttonTextStyle = const TextStyle(fontSize: 25, color: Colors.black);

  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  TextEditingController username = new TextEditingController();

  TextEditingController phoneNumber = new TextEditingController();

  bool isLoggedIn = true;

  var errors = "";

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  TextStyle hintStyle = TextStyle(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(const Radius.circular(20))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                errors != "signed in"
                    ? Text(
                        errors,
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    : const Text(""),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter UserName",
                      hintStyle: hintStyle),
                  controller: username,
                  validator: (value) {
                    print(value);
                    if (value == null || value.isEmpty) {
                      return "Please enter username";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Email",
                      hintStyle: hintStyle),
                  controller: email,
                  validator: (value) {
                    print(value);
                    if (value == null || value.isEmpty) {
                      return "Please enter Email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Password",
                      hintStyle: hintStyle),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: phoneNumber,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter PhoneNumber",
                      hintStyle: hintStyle),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter phno";
                    }
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      context
                          .read<RegistrationProvider>()
                          .signUp(
                              email.text.toString(),
                              password.text.toString(),
                              phoneNumber.text.toString(),
                              username.text.toString())
                          .then((value) {
                        setState(() {
                          errors = value;
                          print(errors);
                        });

                        if (errors == "signed in") {
                          print("go home");
                          Navigator.pushNamed(context, '/home');
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Register",
                        style: KbuttonTextStyle,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
