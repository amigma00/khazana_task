import 'package:flutter/material.dart';

extension AppText on String {
  String get string => this;

  Widget textGilroy300(double fontSize,
          {Color color = Colors.white, TextAlign? textAlign}) =>
      Text(string,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: fontSize, color: color, fontWeight: FontWeight.w300));

  Widget textGilroy400(double fontSize,
          {Color color = Colors.white, TextAlign? textAlign}) =>
      Text(string,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: fontSize, color: color, fontWeight: FontWeight.w400));

  Widget textGilroy500(double fontSize,
          {Color color = Colors.white, TextAlign? textAlign}) =>
      Text(string,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: fontSize, color: color, fontWeight: FontWeight.w500));

  Widget textGilroy600(double fontSize,
          {Color color = Colors.white, TextAlign? textAlign}) =>
      Text(string,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: fontSize, color: color, fontWeight: FontWeight.w600));

  Widget textGilroy700(double fontSize,
          {Color color = Colors.white, TextAlign? textAlign}) =>
      Text(string,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: fontSize, color: color, fontWeight: FontWeight.w700));
}
