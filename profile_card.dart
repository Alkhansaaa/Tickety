import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomProfileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const CustomProfileCard({
    Key? key,
    required this.title, required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.grey.shade200))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon,size:18 ,color: Colors.grey),
                  SizedBox(width: 10,),
                  CustomText(
                    text: title,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold,
                    textSize: 14,
                    textColor: Colors.grey.shade800,
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios , size: 16,color: Colors.grey,)
            ],
          ),
        ],
      ),
    );
  }
}