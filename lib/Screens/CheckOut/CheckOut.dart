import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  bool isDeliverySelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckOut"),
      ),
      body: Column(
        children: [
          Card(
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDeliverySelected = true;
                      });
                    },
                    child: Text(
                      "Delivery",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDeliverySelected = false;
                      });
                    },
                    child: Text(
                      "payment",
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
          ),
          isDeliverySelected == true
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      child: ListView(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelStyle: TextStyle(color: Colors.black),
                                labelText: 'Enter your Address'),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelStyle: TextStyle(color: Colors.black),
                                labelText: 'Enter your pincode'),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelStyle: TextStyle(color: Colors.black),
                                labelText: 'Enter your State'),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                isDeliverySelected = false;
                              });
                            },
                            child: Text(
                              "Continue",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Center(
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {},
                          child: Text(
                            "Continue With Paytm",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
