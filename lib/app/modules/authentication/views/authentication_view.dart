import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:khazana_task/app/components/khazana_button.dart';
import 'package:khazana_task/app/components/khazana_textfield.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isActive = false.obs;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Text.rich(
          TextSpan(
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ), // Default text style
            children: [
              TextSpan(text: 'By signing in, you agree to our '),
              TextSpan(
                text: 'T&C',
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Handle T&C link click
                    print("T&C Clicked");
                  },
              ),
              TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Handle Privacy Policy link click
                    print("Privacy Policy Clicked");
                  },
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            'Welcome Back,\nWe Missed You! 🎉'.textGilroy400(24),
            Gap(8),
            Row(
              children: [
                'Glad to have you back at'.textGilroy400(14),
                GradientText(' Dhan Saarthi',
                    gradient: LinearGradient(colors: [
                      Color(0xff0883FD),
                      Color(0xff8CD1FB),
                    ]),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              ],
            ),
            Gap(82),
            PageView(
              physics: BouncingScrollPhysics(),
              children: [
                Form(
                  key: controller.formKey,
                  child: KhazanaTextfield(
                    label: 'Enter your phone number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (value.length != 10 ||
                          GetUtils.hasMatch(value, r'^\d{11}$')) {
                        return 'Please enter a valid phone number';
                      }

                      return null;
                    },
                    onChanged: (p0) => p0.isEmpty
                        ? isActive.value = false
                        : isActive.value = true,
                    controller: controller.phoneController,
                    prefix: '+91'.textGilroy700(14).paddingOnly(right: 8),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Container()
              ],
            ),
            Gap(56),
            Obx(
              () => KhazanaButton(
                isActive: isActive.value,
                onPressed: () => controller.onProceedTap(),
                text: 'Proceed',
              ).paddingSymmetric(horizontal: 35),
            )
          ],
        ).paddingSymmetric(horizontal: 24));
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(this.text,
      {super.key, required this.gradient, required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: style.copyWith(
            color: Colors.white), // White ensures proper blending
      ),
    );
  }
}
