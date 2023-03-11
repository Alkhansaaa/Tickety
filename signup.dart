// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatelessWidget {

   final formGlobalKey = GlobalKey < FormState > ();
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  resizeToAvoidBottomInset: true,
   backgroundColor: Colors.white,
   appBar: AppBar(
   elevation: 0,
   backgroundColor: Colors.white,
   leading: IconButton(
   onPressed: () {
   Navigator.pop(context);
   },
   icon: Icon(Icons.arrow_back_ios,
  size: 20,
  color: Colors.black,),


), systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
      key: formGlobalKey,
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      height: MediaQuery.of(context).size.height - 50,
      width: double.infinity,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
      Column(
                children: <Widget>[
                  Text("join us!",
                    style: TextStyle(
                      fontSize: 30,
                       fontWeight: FontWeight.bold,
                       color: Colors.amberAccent.shade200
                        ),),
                        SizedBox(height: 20,),
                        Text("Create your account now  ",
                        style: TextStyle(
                        fontSize: 15, 
                        fontWeight: FontWeight.bold,
                        color:Colors.blueAccent.shade100),)

                      ],
                      ),



              Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
              children: [
               TextFormField(
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                labelText:"Username",
                icon: Icon(Icons.person),
                prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
                //fillColor: Colors.black
               ),
      
                validator: (value) {
                if (value == null || value.isEmpty) {
                return 'Please enter some text';
                }
                return null;
                },
                ),
                      
    /* 
                    
                     validator: (value) {
                    if (value.isEmpty) {
                      return "Please Fill";
                    }
                    else{
                      return null;
                    }
                    }*/
                      
                      
                      
                    TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onSaved: (email) {},
                    decoration: InputDecoration(
                    labelText:"Email",
                    icon: Icon(Icons.email),
                    prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
                    //fillColor: Colors.black
                    ),
                     validator: (email) {
                    if (email!.isEmpty) {
                    return ("please Enter You email");}
                    if (!RegExp("^[a-zA-Z0-9=_.-]+@[a-zA-Z0-9=_.-]+.a-z]").hasMatch(email)){
                     return 'Enter a valid email address';
                      }
                     return null;
                      
                      },
                    ),



                   TextFormField(
                   textInputAction: TextInputAction.done,
                   obscureText: true,
                   decoration: InputDecoration(
                   labelText: "Password",
                   icon: Icon(Icons.key_sharp),
                   prefixIcon: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
                   ),
                   validator: (value) {
                   RegExp regex = RegExp(r'^.{6,}$');
                   if (value!.isEmpty) {
                    return ("Password is required for login");
                    }
                     if (!regex.hasMatch(value)) {
                     return ("Enter Valid Password(Min. 6 Character)");
                     }
                     },
       /* onSaved: (value) {
          passwordController.text = value!;
        },*/
                   ),




                 TextFormField(
                 textInputAction: TextInputAction.done,
                 obscureText: true,
                 decoration: InputDecoration(
                 labelText: "Confirm Password",
                 icon: Icon(Icons.key_sharp),
                 prefixIcon: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
                 ) ,
                 ),




               TextFormField(
               textInputAction: TextInputAction.done,
               decoration: InputDecoration(
               labelText: "Phone number",
               icon: Icon(Icons.phone_android),
               prefixIcon: Padding(
               padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
               ),
               ),


              TextFormField(
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
              labelText: "Company register number",
              icon: Icon(Icons.numbers),
              prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
              ),
              )
              ]
              ) 
              ),
                     


                Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration:
                BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border(
                bottom: BorderSide(color: Colors.black),
                top: BorderSide(color: Colors.black),
                left: BorderSide(color: Colors.black),
                right: BorderSide(color: Colors.black),
                 )

                /*ElevatedButton(onPressed: () {
                if (formGlobalKey.currentState.validate()) {
                // use the information provided
                }
                }, child: Text("Submit"))*/
                ),


                child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (formGlobalKey.currentState! .validate) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
                );
                }
                },


                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                   "Sign up", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                  ),
                  ),
                 ),
                 ),



                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text("Already have an account?"),
                Text(" Login", style:TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18
                ),
                )
                ],
               )
               ],
               ),
               ),
               ),
               );
               }


              bool isEmailValid(String email) {
              String pattern = (r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
              RegExp regex = new RegExp(pattern);
              return regex.hasMatch(email);
              }
               bool isPasswordValid(String password) => password.length == 6;
              }

 /*
mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;
}
  bool isEmailValid(String email) {
    Pattern pattern =
     (r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  
}*/