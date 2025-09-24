import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/widgets/custom_auth_button.dart';
import 'package:hungry/shared/custom_text_field.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Gap(100),
                    // logo
                    SvgPicture.asset('assets/logo/logo.svg'),
                    Gap(60),
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
                    Gap(15),
                    // confirm password
                    CustomTextField(
                      hint: 'Confirm Password',
                      isPassword: true,
                      controller: confirmPasswordController,
                    ),
                    Gap(25),
                    // button sign up
                    CustomAuthButton(
                      text: 'Sign up',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          print('success register');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
