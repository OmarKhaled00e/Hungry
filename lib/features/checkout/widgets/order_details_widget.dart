import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/shared/custom_text.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.fees,
    required this.total,
  });
  final String order, taxes, fees, total;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: 'Order summary', size: 20, weight: FontWeight.w500),
        Gap(10),
        checkoutWidget('order', order, false, false),
        Gap(10),
        checkoutWidget('Taxes', taxes, false, false),
        Gap(10),
        checkoutWidget('Delivery fees', fees, false, false),
        Divider(),
        Gap(10),
        checkoutWidget('Total', total, true, false),
        Gap(10),
        checkoutWidget('Estimated delivery time:', '15 - 30 mins', true, true),
      ],
    );
  }

  Widget checkoutWidget(title, price, isBold, isSmall) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          size: isSmall ? 14 : 18,
          weight: isBold ? FontWeight.bold : FontWeight.w400,
          color: isBold ? Colors.black : Colors.grey.shade600,
        ),
        CustomText(
          text: isSmall ? '$price' : '$price \$',
          size: isSmall ? 14 : 18,
          weight: isBold ? FontWeight.bold : FontWeight.w400,
          color: isBold ? Colors.black : Colors.grey.shade600,
        ),
      ],
    );
  }
}
