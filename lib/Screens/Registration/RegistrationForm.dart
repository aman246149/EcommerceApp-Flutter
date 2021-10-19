import 'package:flutter/material.dart';

class RegistrationForm extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final KbuttonTextStyle=TextStyle(fontSize: 25,color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.brown.shade100,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter Email"
            ),
            validator: (value){
              if(value==null || value.isEmpty){
                return "Please enter some text";
              }
              return null;
            },
          ),
          SizedBox(height: 15,),
          TextFormField(
            decoration: InputDecoration(
                hintText: "Enter Password"
            ),
            validator: (value){
              if(value==null || value.isEmpty){
                return "Please enter some text";
              }
              return null;
            },
          ),
          SizedBox(height: 15,),
          TextFormField(
            decoration: InputDecoration(
                hintText: "Enter PhoneNumber"
            ),
            validator: (value){
              if(value==null || value.isEmpty){
                return "Please enter some text";
              }
              return null;
            },
          ),SizedBox(height: 18,),
          FlatButton(
              color: Colors.redAccent.shade100,
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              }, child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Register",style: KbuttonTextStyle,),
              ))
        ],
        ),
      ),
    );
  }
}
