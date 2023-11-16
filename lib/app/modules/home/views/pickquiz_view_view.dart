import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_getx/app/data/model/matkul_model.dart';
import 'package:quiz_getx/app/modules/home/controllers/home_controller.dart';

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
                    onTap: () {
                      Get.toNamed('/quiz', arguments: quiz.idUQuiz);
                    },
                  );
                },
              ));
        });
  }
}
