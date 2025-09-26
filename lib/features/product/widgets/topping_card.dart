import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  const ToppingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onAdd,
  });
  final String imageUrl;
  final String title;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(height: 85, width: 100, color: AppColors.primary),
        ),
        Positioned(
          top: -40,
          right: -1,
          left: -1,
          child: SizedBox(
            height: 70,
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              child: Image.asset(imageUrl, fit: BoxFit.contain),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title,
                  color: Colors.white,
                  size: 14,
                  weight: FontWeight.w600,
                ),
                GestureDetector(
                  onTap: onAdd,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.add, color: Colors.white, size: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
