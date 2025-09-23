import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/widgets/custom_auth_button.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Gap(100),
                  // logo
                  SvgPicture.asset('assets/logo/logo.svg'),
                  Gap(10),
                  // welcom text
                  CustomText(
                    text: 'Welcom back, Discover The Fast Food',
                    color: Colors.white,
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                  Gap(60),
                  //text field email
                  CustomTextField(
                    controller: emailController,
                    hint: 'Email Address',
                    isPassword: false,
                  ),
                  Gap(20),
                  //text field password
                  CustomTextField(
                    controller: passwordController,
                    hint: 'Password',
                    isPassword: true,
                  ),
                  Gap(30),
                  // button loagin
                  CustomAuthButton(
                    text: 'Login',
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        print('success login');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
