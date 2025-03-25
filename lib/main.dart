import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khazana_task/app/constants/app_colors.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: createMaterialColor(AppColors.primaryColor),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
          ),
        ),
        getPages: AppPages.routes,
      ),
    ),
  );
}

MaterialColor createMaterialColor(Color color) {
  Map<int, Color> swatch = {
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color, // Default shade
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color.withOpacity(1.0),
  };
  return MaterialColor(color.value, swatch);
}
