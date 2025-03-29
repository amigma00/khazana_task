// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:khazana_task/app/services/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init(); // Initialize GetStorage

  const String anonKey = String.fromEnvironment('ANON');

  await Supabase.initialize(
      url: 'https://ecxwmipdbfntdazfgiym.supabase.co', anonKey: anonKey);

  Get.put(StorageService());

  runApp(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        theme: ThemeData(
          fontFamily: 'Gilroy',
          scaffoldBackgroundColor: Colors.black,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            unselectedItemColor: AppColors.textFieldBorder,
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: createMaterialColor(AppColors.primaryColor),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
          ),
          dividerTheme: DividerThemeData(
              thickness: .2, space: .2, color: AppColors.textFieldBorder),
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
