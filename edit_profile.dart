import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:new_tick_pro/navigation/navigation_helper.dart';
import 'package:new_tick_pro/ui/bottombar/bottom_nav_bar.dart';
import 'package:new_tick_pro/ui/ticketprovider/ticket_nav_bar.dart';
import 'package:new_tick_pro/widgets/custom_button.dart';
import 'package:new_tick_pro/widgets/custom_textfield.dart';

import '../../../utils/constant.dart';
import '../../../widgets/custom_text.dart';

class EditProfile extends StatefulWidget {
  var data;

  EditProfile({super.key, this.data});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _name = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _companyName = TextEditingController();
  String fullnumbner = "";
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _name.text = widget.data["name"];
    _phoneNumber.text = widget.data["phoneNumber"].substring(4);
    _companyName.text = widget.data["companyName"];
  }

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
      body: SingleChildScrollView(child: Form(key: _key, child: _getUI(context))),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomTextFeild(
            controller: _name,
            lableString: "Fullname",
            padding: 20,
            isName: true,
            validator: (val) => val.isEmpty ? "Required" : null,
            hint: "name"),
        const SizedBox(
          height: 10,
        ),
        widget.data["isCompany"]
            ? CustomTextFeild(
                controller: _companyName,
                lableString: "Company Name",
                padding: 20,
                keyboradType: TextInputType.number,
                validator: (val) => val.isEmpty ? "Required" : null,
                hint: "name")
            : Container(),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: IntlPhoneField(
            style: const TextStyle(color: Colors.black),
            controller: _phoneNumber,
            decoration: const InputDecoration(
              hintText: "+1234",
              labelStyle: TextStyle(color: Colors.grey),
              hintStyle: TextStyle(color: Colors.grey),
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            initialCountryCode: 'SA',
            onChanged: (phone) {
              setState(() {
                fullnumbner = phone.completeNumber;
              });
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
            name: "Update",
            buttonColor: appColor,
            height: 45,
            width: double.infinity,
            textSize: 14,
            textColor: Colors.white,
            fontWeight: FontWeight.w500,
            borderRadius: 6,
            onTapped: () {
              if (!_key.currentState!.validate()) {
                return;
              } else {
                showAlertDialog(context);
              }
            },
            padding: 20)
      ],
    );
  }

  _updateProfile() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "name": _name.text,
      "phoneNumber": fullnumbner,
      "companyName": _companyName.text
    }, SetOptions(merge: true)).then((value) {
      Fluttertoast.showToast(msg: "Profile Updated");
      NavigationHelper.pushReplacement(
          context,
          widget.data["isCompany"]
              ? const TicketNavBar()
              : const BottomNavBody());
    });
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomText(
              text: "Update Profile",
              textSize: 16,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.start,
              textColor: Colors.black),
          content: const CustomText(
              text: "Are you sure you want to update Profile?",
              textSize: 14,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w500,
              textColor: Colors.black),
          actions: [
            TextButton(
              child: const CustomText(
                  text: "Cancel",
                  textSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const CustomText(
                  text: "Update",
                  textSize: 16,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.green),
              onPressed: () {
                _updateProfile();
              },
            ),
          ],
        );
      },
    );
  }
}
