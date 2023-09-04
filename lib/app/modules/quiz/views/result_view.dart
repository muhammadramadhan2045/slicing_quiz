import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_getx/app/modules/quiz/controllers/quiz_controller.dart';

class ResultView extends GetView<QuizController> {
  const ResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResultView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Skor Anda: ${controller.score.value}/${controller.questions.length} ',
            ),
            ElevatedButton(
              onPressed: () {
                // Kembali ke halaman kuis atau halaman lain jika diperlukan
                Get.offAllNamed('home');
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
