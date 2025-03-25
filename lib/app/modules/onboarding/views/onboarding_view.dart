import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:khazana_task/app/constants/app_images.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          Expanded(
            child: 'One step closer to smarter investing. Let’s begin!'
                .textGilroy400(14, color: AppColors.labelGrey),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    onPressed: () => controller.navigate(),
                    child: const Icon(Icons.arrow_forward)),
              ],
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.logo,
            alignment: Alignment.center,
          ),
          Gap(46),
          'Welcome to\n DhanSaarthi !'
              .textGilroy400(32, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
