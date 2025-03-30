import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khazana_task/app/components/khazana_theme.dart';

import 'package:khazana_task/app/services/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();

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
        theme: khazantheme(),
        getPages: AppPages.routes,
      ),
    ),
  );
}
