import 'package:ecommerce/Providers/RegistrationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final KbuttonTextStyle = TextStyle(fontSize: 25, color: Colors.white);

  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  bool isLoggedIn = true;

  var errors = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.brown.shade100,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            errors != "signed in"
                ? Text(
                    errors,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                : Text(""),
            TextFormField(
              decoration: InputDecoration(hintText: "Enter Email"),
              controller: email,
              validator: (value) {
                print(value);
                if (value == null || value.isEmpty) {
                  return "Please enter Email";
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(hintText: "Enter Password"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter password";
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Enter PhoneNumber"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter phno";
                }
              },
            ),
            SizedBox(
              height: 18,
            ),
            FlatButton(
                color: Colors.redAccent.shade100,
                onPressed: () {
                  context
                      .read<RegistrationProvider>()
                      .signUp(email.text.toString(), password.text.toString())
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
    );
  }
}
