import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_getx/app/data/model/matkul_model.dart';
import 'package:quiz_getx/app/modules/home/controllers/home_controller.dart';
import 'package:quiz_getx/app/modules/home/views/widget/explanation_widget.dart';
import 'package:quiz_getx/app/routes/app_pages.dart';

class PickquizViewView extends GetView<HomeController> {
  const PickquizViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: controller,
        builder: (cntroller) {
          final List<Quiz> quizzes =
              controller.getQuizzesForMataKuliah(Get.arguments.toString());
          return Scaffold(
              appBar: AppBar(
                title: const Text('PickquizViewView'),
                centerTitle: true,
              ),
              body: ListView.builder(
                itemCount: quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = quizzes[index];
                  return ListTile(
                    title: Text(quiz.namaQuiz),
                    subtitle: Text("Tanggal: ${quiz.tanggalQuiz.toString()}"),
                    trailing: Text("Durasi: ${quiz.durasiPengerjaan}"),
                    onTap: () {
                      Get.bottomSheet(
                        ExplanationWidget(
                          onPressed: () =>
                              Get.offAllNamed(Routes.QUIZ, arguments: quiz),
                        ),
                        enterBottomSheetDuration:
                            const Duration(milliseconds: 100),
                        exitBottomSheetDuration:
                            const Duration(milliseconds: 100),
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
                  );
                },
              ));
        });
  }
}
