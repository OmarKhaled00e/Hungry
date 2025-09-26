import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/widgets/custom_auth_button.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_text_field.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(200),
                // logo
                SvgPicture.asset(
                  'assets/logo/logo.svg',
                  color: AppColors.primary,
                ),
                CustomText(
                  text: 'Welcome to our Food App',
                  color: AppColors.primary,
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
                          // text fiedl name
                          CustomTextField(
                            hint: 'Name',

                            isPassword: false,
                            controller: nameController,
                          ),
                          Gap(15),
                          //text field email
                          CustomTextField(
                            hint: 'Email Address',
                            isPassword: false,
                            controller: emailController,
                          ),
                          Gap(15),
                          // text field password
                          CustomTextField(
                            hint: 'Password',
                            isPassword: true,
                            controller: passwordController,
                          ),
                          Gap(30),
                          // button sign up
                          CustomAuthButton(
                            color: AppColors.primary,
                            textColor: Colors.white,
                            text: 'Sign up',

                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                print('success register');
                              }
                            },
                          ),
                          Gap(15),
                          CustomAuthButton(
                            text: 'Go to Login ?',
                            color: Colors.white,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) {
                                    return LoginView();
                                  },
                                ),
                              );
                            },
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
