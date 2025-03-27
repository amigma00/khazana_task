import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:khazana_task/app/components/gradient_text.dart';
import 'package:khazana_task/app/components/khazana_button.dart';
import 'package:khazana_task/app/components/khazana_textfield.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:pinput/pinput.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 28,
      height: 60,
      textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.primaryColor, width: 3),
        ),
      ),
    );
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
        ).paddingSymmetric(horizontal: 16),
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
            Expanded(
              child: PageView(
                controller: controller.pageController,
                clipBehavior: Clip.none,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  enterNumber(controller.isActive),
                  otpSection(defaultPinTheme)
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 24));
  }

  Column otpSection(PinTheme defaultPinTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        'Enter OTP'.textGilroy400(14),
        Obx(
          () => Pinput(
            length: 6,
            controller: controller.otpController.value,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            defaultPinTheme: defaultPinTheme,
            onChanged: (value) {
              if (value.length == 6) {
                controller.isActive.value = true;
              } else {
                controller.isActive.value = !true;
              }
            },
            followingPinTheme: defaultPinTheme.copyWith(
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(color: AppColors.textFieldBorder, width: 3),
                ),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyWith(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.errorColor, width: 3),
                ),
              ),
            ),
            errorTextStyle: TextStyle(
              color: AppColors.errorColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            errorText: 'Invalid OTP! Please try again',
            forceErrorState: controller.isOtpError.value,
          ),
        ),
        Gap(34),
        Obx(
          () => Row(
            children: [
              Visibility(
                  visible: controller.timer.value.isEmpty,
                  replacement:
                      '${controller.timer.value} sec'.textGilroy400(12),
                  child: "Didn't Receive OPT?".textGilroy400(12)),
              KhazanaButton(
                onPressed: controller.timer.value.isEmpty
                    ? () => controller.onResendTap()
                    : null,
                text: "Resend",
                color: Colors.transparent,
                textColor: controller.timer.value.isEmpty
                    ? AppColors.primaryColor
                    : AppColors.labelGrey,
              )
            ],
          ),
        ),
        Gap(16),
        Row(
          children: [
            Obx(
              () =>
                  'OTP has been sent on ${maskPhoneNumber(controller.phoneController.value.text)}'
                      .textGilroy400(12, color: AppColors.labelGrey),
            ),
            IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: BoxConstraints(),
                onPressed: () => controller.onEditNumberTap(),
                icon: Icon(Icons.edit, size: 18, color: AppColors.labelGrey))
          ],
        ),
        Gap(56),
        Obx(
          () => KhazanaButton(
            isActive: controller.isActive.value,
            onPressed: controller.isActive.value
                ? () => controller.onOtpProceedTap()
                : null,
            text: 'Proceed',
          ).paddingSymmetric(horizontal: 35),
        )
      ],
    );
  }

  String maskPhoneNumber(String phoneNumber) {
    
    if (phoneNumber.length < 4) return phoneNumber; // Handle short numbers
    return '${phoneNumber.substring(0, 3)}*****${phoneNumber.substring(phoneNumber.length - 3)}';
  }

  Column enterNumber(RxBool isActive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
            onChanged: (p0) =>
                p0.isEmpty ? isActive.value = false : isActive.value = true,
            controller: controller.phoneController.value,
            prefix: '+91'.textGilroy700(14).paddingOnly(right: 8),
            keyboardType: TextInputType.phone,
          ),
        ),
        Gap(56),
        Obx(
          () => KhazanaButton(
            isActive: isActive.value,
            onPressed: controller.isActive.value
                ? () => controller.onNumberProceedTap()
                : null,
            text: 'Proceed',
          ).paddingSymmetric(horizontal: 35),
        )
      ],
    );
  }
}
