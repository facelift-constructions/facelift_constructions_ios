import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/log_in/phone_auth_page.dart';
import 'package:flutter/material.dart';

import '../premium/new_premium_user.dart';

class GetPremiumButton extends StatelessWidget {
  const GetPremiumButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => userLogedIn
                ? const NewPrimiumUserScreen()
                : const PhoneAuthScreen()),
      ),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: const Color(0xffff72b9),
            borderRadius: BorderRadius.circular(32)),
        child: const Center(child: Text("Design Your Home Now")),
      ),
    );
  }
}
