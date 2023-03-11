import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_tick_pro/widgets/custom_button.dart';
import 'package:new_tick_pro/widgets/custom_textfield.dart';

import '../../../utils/constant.dart';
import '../../../widgets/custom_text.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        elevation: 0,
        title: const CustomText(
            text: "Change Password",
            textSize: 18,
            fontWeight: FontWeight.bold,
            textColor: Colors.white),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body:
          Form(key: _key, child: SingleChildScrollView(child: _getUI(context))),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomTextFeild(
            controller: _newPassword,
            lableString: "New Password",
            padding: 20,
            passwordField: true,
            validator: (val) => val.isEmpty ? "Required" : null,
            hint: "*****"),
        CustomTextFeild(
            controller: _confirmPassword,
            lableString: "Confirm Password",
            padding: 20,
            passwordField: true,
            validator: (val) => val.isEmpty ? "Required" : null,
            hint: "*****"),
        const SizedBox(
          height: 30,
        ),
        CustomButton(
            name: "Change",
            buttonColor: appColor,
            height: 45,
            width: double.infinity,
            textSize: 14,
            textColor: Colors.white,
            fontWeight: FontWeight.w500,
            borderRadius: 8,
            onTapped: () {
              if (!_key.currentState!.validate()) {
                return;
              }

              if (_newPassword.text.length < 6 &&
                  _confirmPassword.text.length < 6) {
                Fluttertoast.showToast(msg: "Minimum 6 word's");
              }else{
                if (_newPassword.text == _confirmPassword.text) {
                  _changePassword(_confirmPassword.text);
                } else {
                  Fluttertoast.showToast(msg: "Password not match");
                }
              }


            },
            padding: 20)
      ],
    );
  }

  void _changePassword(String password) async {
    User user = await FirebaseAuth.instance.currentUser!;

    user.updatePassword(password).then((_) {
      _newPassword.clear();
      _confirmPassword.clear();
      setState(() {});

      Fluttertoast.showToast(msg: "Successfully changed password");
    }).catchError((error) {
      if ("[firebase_auth/requires-recent-login] This operation is sensitive and requires recent authentication. Log in again before retrying this request." ==
          error.toString()) {
        print(error.toString());
        Fluttertoast.showToast(
            msg: "Sensitive Data Re-login to change password");
      }
    });
  }
}
