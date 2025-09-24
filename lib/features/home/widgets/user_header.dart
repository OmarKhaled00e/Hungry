import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(30),
            // logo
            SvgPicture.asset(
              'assets/logo/logo.svg',
              color: AppColors.primary,
              height: 35,
            ),
            Gap(5),
            CustomText(
              text: 'Hello, Rich Sonic',
              size: 16,
              weight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ],
        ),
        Spacer(),
        // profile image
        CircleAvatar(
          radius: 28,
          child: Icon(CupertinoIcons.person, color: Colors.white),
          backgroundColor: AppColors.primary,
        ),
      ],
    );
  }
}
