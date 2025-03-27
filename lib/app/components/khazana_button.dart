import 'package:flutter/material.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';

class KhazanaButton extends StatelessWidget {
  final String? text;
  final bool isActive;
  final void Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final Widget? child;
  const KhazanaButton(
      {super.key,
      this.text,
      required this.onPressed,
      this.isActive = true,
      this.color,
      this.textColor,
      this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: isActive
            ? color ?? AppColors.primaryColor
            : AppColors.textFieldFillColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: .75,
              color: isActive ? Color(0xFF000000) : AppColors.textFieldBorder),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 11),
      ),
      child: child ??
          (text ?? '--').textGilroy300(14, color: textColor ?? Colors.white),
    );
  }
}
