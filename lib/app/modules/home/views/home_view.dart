import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_getx/app/modules/home/views/widget/explanation_widget.dart';
// import 'package:quiz_getx/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Menampilkan bottom sheet dengan penjelasan
                Get.bottomSheet(
                  ExplanationWidget(),
                  enterBottomSheetDuration: const Duration(milliseconds: 500),
                  exitBottomSheetDuration: const Duration(milliseconds: 500),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  isDismissible: true,
                  enableDrag: true,
                  clipBehavior: Clip.none,
                  backgroundColor: Colors.white,
                );
              },
              child: Text('Mulai Kuis'),
            ),
          ],
        ),
      ),
    );
  }
}
