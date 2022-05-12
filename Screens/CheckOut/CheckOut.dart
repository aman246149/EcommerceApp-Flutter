import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckOut extends StatefulWidget {
  final price;
  final title;
  const CheckOut({Key? key, this.price, this.title}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  bool isDeliverySelected = true;

  final _razorpay = Razorpay();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  int _activeCurrentStep = 0;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    print(response);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("orders")
        .doc(response.orderId)
        .set({
      "productname": widget.title,
      "totalPrice": widget.price,
      "orderId": response.orderId,
      "paymentId": response.paymentId,
      "name": nameController.text,
      "phone": phoneController.text,
      "pincode": pincodeController.text,
      "address": addressController.text,
      "state": stateController.text
    });
    Navigator.pushNamed(context, '/home');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(response.walletName);
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  Future<String> generateOrderId(String key, String secret, int amount) async {
    var authn = 'Basic ' + base64Encode(utf8.encode('$key:$secret'));

    var headers = {
      'content-type': 'application/json',
      'Authorization': authn,
    };

    var data =
        '{ "amount": $amount, "currency": "INR", "receipt": "receipt#R1", "payment_capture": 1 }'; // as per my experience the receipt doesn't play any role in helping you generate a certain pattern in your Order ID!!

    var res = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'),
        headers: headers, body: data);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    print('ORDER ID response => ${res.body}');

    return json.decode(res.body)['id'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "CheckOut",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Stepper(
          currentStep: _activeCurrentStep,
          onStepContinue: () async {
            if (_activeCurrentStep < 1) {
              setState(() => _activeCurrentStep += 1);
            } else {
              String key = await generateOrderId("rzp_test_wfxFEandq8uEb7",
                  "lbru9KLkkzitIWZMJt8aL6st", widget.price);
              _razorpay.open({
                'key': "rzp_test_wfxFEandq8uEb7",
                'amount': (widget.price) * 100,
                'name': nameController.text.toString(),
                "order_id": key,
                'description': widget.title,
                'prefill': {
                  'contact': phoneController.text.toString(),
                  'email': FirebaseAuth.instance.currentUser!.email
                }
              });
            }
          },
          onStepCancel: () {
            _activeCurrentStep > 0
                ? setState(() => _activeCurrentStep -= 1)
                : null;
          },
          steps: [
            Step(
                state: _activeCurrentStep <= 0
                    ? StepState.editing
                    : StepState.complete,
                isActive: _activeCurrentStep >= 0,
                title: Text("Personal Info"),
                content: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Enter Your Name"),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration:
                          InputDecoration(hintText: "Enter Your PhoneNumber"),
                    ),
                    TextField(
                      controller: addressController,
                      decoration:
                          InputDecoration(hintText: "Enter Your Address"),
                    ),
                    TextField(
                      controller: pincodeController,
                      decoration:
                          InputDecoration(hintText: "Enter Your Pincode"),
                    ),
                    TextField(
                      controller: stateController,
                      decoration: InputDecoration(hintText: "Enter Your State"),
                    ),
                  ],
                )),
            Step(
                isActive: _activeCurrentStep >= 1,
                title: Text("Continue for Payment"),
                content: Text(""))
          ]),
    );
  }
}
