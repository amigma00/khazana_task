import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';

class KhazanaTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? prefix, suffix;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? label, hintText;
  final void Function(String)? onFieldSubmitted;

  const KhazanaTextfield({
    super.key,
    required this.controller,
    this.validator,
    this.prefix,
    this.keyboardType,
    this.prefixIcon,
    this.onChanged,
    this.label,
    this.hintText,
    this.suffix,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Visibility(
            visible: label != null,
            child: (label ?? '').textGilroy400(14).paddingOnly(bottom: 12)),
        TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  color: AppColors.textFieldBorder,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              prefix: prefix,
              prefixIcon: prefixIcon,
              suffix: suffix,
              prefixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              isDense: true,
              filled: true,
              fillColor: AppColors.textFieldFillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.textFieldBorder),
              )),
        ),
      ],
    );
  }
}
