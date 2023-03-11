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
                    color:Colors.amber[700]

                  ),),
                  SizedBox(height: 20,),
                  Text("Create your account now  ",
                    style: TextStyle(
                        fontSize: 15,
                        color:Colors.blueAccent[100]),)


                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      TextFormField(
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
             labelText: "Username",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
              
              ),
              validator: (value) {
             if (value == null || value.isEmpty) {
            return 'Field is required.';
              }
              return null;
},
onSaved: (value) {
}
            ),
                      TextFormField(
             keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSaved: (email) {},
            decoration: InputDecoration(
              labelText:"Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
          
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
                 labelText: "password",
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
        
            ),

            TextFormField(
               textInputAction: TextInputAction.done,
              obscureText: true,
            decoration: InputDecoration(
               labelText: "Confirm Password",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
              
              ),
              //validator: (password) {
              /*if (isPasswordValid(password)) return null;
               else
                 return 'Enter a valid password';
             },*/
            ),

            TextFormField(
             textInputAction: TextInputAction.done,
            decoration: InputDecoration(
               labelText: "Phone number",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
              
              ),

            ),
            /*TextFormField(
             textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: "Company register number",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 2)),
     
              ),
            )*/
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


                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {},
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),

                  ),
                  child: Text(
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
