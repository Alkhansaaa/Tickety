import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_tick_pro/navigation/navigation_helper.dart';
import 'package:new_tick_pro/ui/auth/start_Screen.dart';
import 'package:new_tick_pro/widgets/custom_button.dart';
import 'package:new_tick_pro/widgets/custom_textfield.dart';

import '../../../utils/constant.dart';
import '../../../widgets/custom_text.dart';

class DeleteUser extends StatefulWidget {
  final String email;

  const DeleteUser({super.key, required this.email});

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        elevation: 0,
        title: const CustomText(
            text: "Edit Profile",
            textSize: 18,
            fontWeight: FontWeight.bold,
            textColor: Colors.white),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        CustomTextFeild(
            controller: _password,
            lableString: "Enter Your Password",
            padding: 20,
            validator: (val) => null,
            hint: "******"),
        SizedBox(
          height: 20,
        ),
        CustomButton(
            name: "Delete",
            buttonColor: appColor,
            height: 50,
            width: double.infinity,
            textSize: 14,
            textColor: Colors.white,
            fontWeight: FontWeight.w500,
            borderRadius: 6,
            onTapped: () {
              _deleteuser();
            },
            padding: 20)
      ],
    );
  }

  _deleteuser() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: widget.email, password: _password.text)
          .then((value) async {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .delete()
            .then((value) async {
          await FirebaseAuth.instance.currentUser!.delete().then((value) {
            Fluttertoast.showToast(msg: "User Deleted");
            NavigationHelper.pushReplacement(context, StartScreen());
          });
        });
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }
}
