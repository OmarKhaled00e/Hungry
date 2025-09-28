import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.text,
    required this.description,
    required this.rate,
  });
  final String image, text, description, rate;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -10,
                  right: 0,
                  left: 0,
                  child: Image.asset('assets/icon/shadow.png'),
                ),
                Center(child: Image.asset(image, width: 120, height: 120)),
              ],
            ),
            Gap(15),
            CustomText(text: text, weight: FontWeight.bold),
            CustomText(text: description),
            Row(
              children: [
                CustomText(text: '⭐ $rate'),
                Spacer(),
                Icon(CupertinoIcons.heart, color: AppColors.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
