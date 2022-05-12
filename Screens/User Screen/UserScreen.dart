import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Providers/RegistrationProvider.dart';
import 'package:ecommerce/Providers/ThemeSwitcherProvider.dart';
import 'package:ecommerce/Screens/Login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String name = "";

  getData() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      name = data.data()!["username"];
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.red,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1524117074681-31bd4de22ad3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
                      radius: 34,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name),
                          Text(FirebaseAuth.instance.currentUser!.email
                              .toString())
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ));
                        },
                        child: Text(
                          "Signout",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Your Orders",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: Container(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("orders")
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text("orderId"),
                                subtitle: Text((snapshot.data as dynamic)
                                    .docs[index]["orderId"]),
                                trailing: Column(
                                  children: [
                                    Text(
                                      "Product name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      (snapshot.data as dynamic)
                                          .docs[index]["productname"]
                                          .toString()
                                          .substring(0, 10),
                                    ),
                                  ],
                                ),
                                leading: Column(
                                  children: [
                                    Text(
                                      "Price",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text((snapshot.data as dynamic)
                                        .docs[index]["totalPrice"]
                                        .toString()),
                                  ],
                                ),
                              );
                            });
                      }

                      return Center(
                        child: Text("No orders yet"),
                      );
                    },
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
