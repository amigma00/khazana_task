import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khazana_task/app/components/text_extension.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(24),
      children: ['Welcome User,'.textGilroy400(24)],
    );
  }
}
