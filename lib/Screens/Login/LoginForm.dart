import 'package:ecommerce/Providers/RegistrationProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final KbuttonTextStyle = TextStyle(fontSize: 25, color: Colors.white);

  String email = "";

  String password = "";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: LoginForm._formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.brown.shade100,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            error.isNotEmpty
                ? Text(
                    error,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                        fontSize: 25),
                  )
                : Text(""),
            TextFormField(
              decoration: InputDecoration(hintText: "Enter Email"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter Email";
                } else {
                  email = value;
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Enter Password"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter password";
                } else {
                  password = value;
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 18,
            ),
            FlatButton(
                color: Colors.redAccent.shade100,
                onPressed: () {
                  if (LoginForm._formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    context
                        .read<RegistrationProvider>()
                        .signInWithEmailAndPassword(email, password);
                    // var user=Provider.of<RegistrationProvider>(context, listen: false).userCredential;
                    var isErrorPassword = Provider.of<RegistrationProvider>(
                            context,
                            listen: false)
                        .wrongPassword;
                    var isErrorNoUser = Provider.of<RegistrationProvider>(
                            context,
                            listen: false)
                        .noUserFoundForThismale;

                    if (!isErrorNoUser.isEmpty) {
                      setState(() {
                        error = isErrorNoUser;
                      });
                      return;
                    }

                    if (!isErrorPassword.isEmpty) {
                      print(isErrorPassword);
                      setState(() {
                        error = isErrorPassword;
                      });
                      return;
                    }
                    Navigator.pushNamed(context, '/product');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Login",
                    style: KbuttonTextStyle,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
