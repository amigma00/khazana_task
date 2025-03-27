import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/charts_controller.dart';

class ChartsView extends GetView<ChartsController> {
  const ChartsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChartsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChartsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
