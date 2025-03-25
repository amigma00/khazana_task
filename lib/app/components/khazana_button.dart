import 'package:flutter/material.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';

class KhazanaButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final void Function() onPressed;
  const KhazanaButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isActive ? onPressed : null,
      style: TextButton.styleFrom(
        backgroundColor:
            isActive ? AppColors.primaryColor : AppColors.textFieldFillColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: .75,
              color: isActive ? Color(0xFF000000) : AppColors.textFieldBorder),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 11),
      ),
      child: text.textGilroy300(14),
    );
  }
}
