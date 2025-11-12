import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/checkout/widgets/order_details_widget.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_snack.dart';
import 'package:hungry/shared/custom_text.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.totalPrice});
  final double totalPrice;
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';
  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;

  /// get profile
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderDetailsWidget(
                order: widget.totalPrice.toString() ?? '18.5',
                taxes: '3.50',
                fees: '40.33',
                total:
                    (double.parse(widget.totalPrice.toString()) + 3.50 + 40.33)
                        .toStringAsFixed(2),
              ),
              Gap(80),
              CustomText(
                text: 'Payment methods',
                size: 20,
                weight: FontWeight.w500,
              ),

              Gap(15),
              //Cash
              ListTile(
                onTap: () {
                  setState(() {
                    selectedMethod = 'Cash';
                  });
                },
                contentPadding: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Color(0xff3C2F2F),
                title: CustomText(
                  text: 'Cash on Delivery',
                  color: Colors.white,
                ),
                leading: Image.asset('assets/icon/cash.png', width: 50),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Cash',
                  groupValue: selectedMethod,
                  onChanged: (v) {
                    selectedMethod = v!;
                  },
                ),
              ),
              Gap(10),
              //Debit
              userModel?.visa == null
                  ? SizedBox.shrink()
                  : ListTile(
                      onTap: () {
                        setState(() {
                          selectedMethod = 'Visa';
                        });
                      },
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      tileColor: Color(0xffF3F4F6),
                      title: CustomText(
                        text: 'Debit card',
                        color: Color(0xff3C2F2F),
                      ),
                      subtitle: CustomText(
                        text: userModel?.visa ?? '**** **** 2342',
                        color: Color(0xff808080),
                      ),
                      leading: Image.asset('assets/icon/visa.png', width: 50),
                      trailing: Radio<String>(
                        activeColor: Colors.blue.shade900,
                        value: 'Visa',
                        groupValue: selectedMethod,
                        onChanged: (v) {
                          setState(() {
                            selectedMethod = v!;
                          });
                        },
                      ),
                    ),
              Gap(5),
              Row(
                children: [
                  Checkbox(
                    activeColor: Color(0xffEF2A39),
                    value: true,
                    onChanged: (v) {},
                  ),
                  CustomText(text: 'Save card details for future payments'),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 15,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'Total', size: 20),
                    CustomText(
                      text:
                          '\$ ${(double.parse(widget.totalPrice.toString()) + 3.50 + 40.33).toStringAsFixed(2)}',
                      size: 27,
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Pay Now',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 200,
                            ),
                            child: Container(
                              width: 300,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 15,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    radius: 40,
                                    child: Icon(
                                      CupertinoIcons.check_mark,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  Gap(10),
                                  CustomText(
                                    text: 'Success !',
                                    color: AppColors.primary,
                                    weight: FontWeight.bold,
                                    size: 20,
                                  ),
                                  Gap(3),
                                  CustomText(
                                    text:
                                        'Your payment was successful.\n A receipt for this purchase has\n been sent to your email.',
                                    color: Colors.grey.shade500,
                                    size: 11,
                                  ),
                                  Gap(8),
                                  CustomButton(
                                    text: 'Go Back',
                                    width: 200,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
