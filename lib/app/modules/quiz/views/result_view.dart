import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_getx/app/modules/quiz/controllers/quiz_controller.dart';

class ResultView extends GetView<QuizController> {
  const ResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var result = (controller.score.value / controller.questions.length) * 100;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  'Tes Pengetahuan Umum 1',
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.blue,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    'Skor Anda: ${result.toStringAsFixed(0)} ',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                //total question
                Text(
                  'Total Pertanyaan: ${controller.questions.length}',
                  style: const TextStyle(fontSize: 18),
                ),

                //correct answer
                Text(
                  'Jawaban Benar: ${controller.score.value}',
                  style: const TextStyle(fontSize: 18),
                ),

                //wrong answer
                Text(
                  'Jawaban Salah: ${controller.questions.length - controller.score.value}',
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  'Tidak Dijawab: ${emptyAnswer()}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('home');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blue,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.5, 50),
              ),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }

  int emptyAnswer() {
    int count = 0;
    controller.questions_temp.forEach((element) {
      if (element['user_answer'] == null) {
        count++;
      }
    });
    return count;
  }
}
