import 'package:ecommerce/Screens/HomePage/HomePage.dart';
import 'package:ecommerce/Screens/Registration/Registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PersistantAuth extends StatefulWidget {
  const PersistantAuth({Key? key}) : super(key: key);

  @override
  State<PersistantAuth> createState() => _PersistantAuthState();
}

class _PersistantAuthState extends State<PersistantAuth> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return HomePage();
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }
          return Registration();
        }));
  }
}
