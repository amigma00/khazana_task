import 'package:flutter/material.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';

class KhazanaButton extends StatelessWidget {
  final String? text;
  final bool isActive;
  final void Function()? onPressed;
  final Color? color, borderColor;
  final Color? textColor;
  final Widget? child;
  final double? height, width, radius;
  final EdgeInsetsGeometry? padding;
  const KhazanaButton(
      {super.key,
      this.text,
      required this.onPressed,
      this.isActive = true,
      this.color,
      this.textColor,
      this.child,
      this.borderColor,
      this.height,
      this.width,
      this.padding,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: isActive
                ? color ?? AppColors.primaryColor
                : AppColors.textFieldFillColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: .75,
                  color: borderColor ??
                      (isActive
                          ? Color(0xFF000000)
                          : AppColors.textFieldBorder)),
              borderRadius: BorderRadius.circular(radius ?? 10),
            ),
            padding: padding ?? EdgeInsets.symmetric(vertical: 11),
            minimumSize: Size(0, 0)),
        child: child ??
            (text ?? '--').textGilroy300(14, color: textColor ?? Colors.white),
      ),
    );
  }
}
