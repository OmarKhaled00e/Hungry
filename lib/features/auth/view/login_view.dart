import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/view/signup_view.dart';
import 'package:hungry/features/auth/widgets/custom_auth_button.dart';
import 'package:hungry/root.dart';
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
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Gap(200),
                // logo
                SvgPicture.asset(
                  'assets/logo/logo.svg',
                  color: AppColors.primary,
                ),
                Gap(10),
                // welcom text
                CustomText(
                  text: 'Welcom back, Discover The Fast Food',
                  color: AppColors.primary,
                  size: 13,
                  weight: FontWeight.w500,
                ),
                Gap(100),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Gap(30),
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
                            color: AppColors.primary,
                            textColor: Colors.white,
                            text: 'Login',
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                print('success login');
                              }
                            },
                          ),
                          Gap(15),
                          // go to signup
                          CustomAuthButton(
                            text: 'Create Account',
                            color: Colors.white,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) {
                                    return SignupView();
                                  },
                                ),
                              );
                            },
                          ),
                          // Guset
                          Gap(20),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (c) => Root()),
                              );
                            },
                            child: CustomText(
                              text: 'Continue as a guest ?',
                              size: 13,
                              color: Colors.blue,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
