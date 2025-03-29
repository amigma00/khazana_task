import 'package:flutter/widgets.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';

void khazanSnackbar(BuildContext context,
    {required String msg, bool error = false}) {
  InteractiveToast.slide(
    toastSetting: SlidingToastSetting(
        padding: EdgeInsets.zero,
        toastStartPosition: ToastPosition.right,
        toastAlignment: Alignment.topRight),
    toastStyle: ToastStyle(
      progressBarColor:
          error ? AppColors.errorColor : AppColors.investCalcGreen,
      border: Border(
          left: BorderSide(
        width: 3,
        color: error ? AppColors.errorColor : AppColors.investCalcGreen,
      )),
      padding: EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(3),
      backgroundColor: AppColors.textFieldFillColor,
    ),
    context,
    title: msg.textGilroy400(10),
    // trailing: trailingWidget(),
  );
}
