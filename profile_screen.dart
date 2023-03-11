import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_tick_pro/navigation/navigation_helper.dart';
import 'package:new_tick_pro/ui/auth/start_Screen.dart';
import 'package:new_tick_pro/ui/screens/change_password/change_password.dart';
import 'package:new_tick_pro/ui/screens/deleteuser/delete_user.dart';
import 'package:new_tick_pro/ui/screens/myTicket/my_ticket.dart';
import 'package:new_tick_pro/ui/screens/organizationDescription/add_description.dart';
import 'package:new_tick_pro/utils/constant.dart';
import 'package:new_tick_pro/widgets/custom_button.dart';

import '../../widgets/custom_text.dart';
import '../../widgets/profile_card.dart';
import 'editProfile/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : _getUI(context));
  }

  Widget _getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          const SizedBox(
            height: 20,
          ),
          
          const CustomText(text: "Welcome", textSize: 14, fontWeight: FontWeight.normal, textColor: appColor),
          const SizedBox(height: 5,),
          CustomText(text: userData["name"], textSize: 16, fontWeight: FontWeight.bold, textColor: Colors.black),
          CustomText(text: userData["email"], textSize: 14, fontWeight: FontWeight.normal, textColor: Colors.grey.shade500),

          InkWell(
            onTap: () {
              NavigationHelper.pushRoute(
                  context,
                  EditProfile(
                    data: userData, 
                  ));
            },
            child:  const CustomProfileCard(
                title: "Edit Profile", icon: Icons.edit,),
          ),
          userData["isCompany"] == false ?InkWell(
            onTap: () {
              NavigationHelper.pushRoute(context, const MyTicketProvider());
            },
            child: const CustomProfileCard(
                title: "History",
                icon: Icons.history),
          ):Container(),
          userData["isCompany"]?InkWell(
            onTap: () {
              NavigationHelper.pushRoute(context,  AddDescription(description: userData["description"],));
            },
            child: const CustomProfileCard(
                title: "Add or edit Brief Description\nof organization",
                icon: Icons.view_compact_alt_outlined),
          ):Container(),





          InkWell(
            onTap: () {
              NavigationHelper.pushRoute(context, const ChangePassword());
            },
            child: const CustomProfileCard(
                title: "Change Password",
                icon: Icons.password_rounded),
          ),
          userData["isCompany"]?InkWell(
            onTap: () {
              NavigationHelper.pushRoute(context, const MyTicketProvider());
            },
            child: const CustomProfileCard(
                title: "Tickets",
                icon: Icons.movie_creation_outlined),
          ):Container(),

          InkWell(
            onTap: () {
              showAlertDialog(context, "Delete Account",
                  "You will lose your all data permanently", () {
                Navigator.pop(context);
                NavigationHelper.pushRoute(
                    context,
                    DeleteUser(
                      email: userData["email"],
                    ));
              }, "Delete");
            },
            child: const CustomProfileCard(
                title: "Delete Account" ,icon: Icons.delete),
          ),
          InkWell(
              onTap: () {
                showAlertDialog(
                    context, "Logout", "Are you sure you want to Logout?", () {
                  _logout();
                }, "Logout");
              },
              child: const CustomProfileCard(
                  title: "Logout", icon: Icons.logout)),
        ],
      ),
    );
  }

  _logout() async {
    await FirebaseAuth.instance.signOut().then((value) {
      NavigationHelper.pushReplacement(context, const StartScreen());
    });
  }


  showAlertDialog(BuildContext context, String title, String content,
      Function onPress, String buttonText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(
              text: title,
              textSize: 16,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.start,
              textColor: Colors.red),
          content: CustomText(
              text: content,
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
              child: CustomText(
                  text: buttonText,
                  textSize: 16,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.red),
              onPressed: () => onPress(),
            ),
          ],
        );
      },
    );
  }

  _getUserDetails() async {
    isLoading = true;
    setState(() {});

    String userID = FirebaseAuth.instance.currentUser!.uid;
    print(userID);
    userData =
        await FirebaseFirestore.instance.collection("Users").doc(userID).get();
    isLoading = false;
    print(userData.data());
    setState(() {});
  }
}
