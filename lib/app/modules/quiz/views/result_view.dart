import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_getx/app/modules/quiz/controllers/quiz_controller.dart';

class ResultView extends GetView<QuizController> {
  const ResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var result = (controller.score.value /
            controller.getQuestionsForQuiz(controller.quiz.idUQuiz).length) *
        100;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            'Hasil',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.15,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Nilai Hasil Ujian Anda',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                result.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //keterangan center text
                    const Center(
                      child: Text(
                        'Keterangan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total Pertanyaan: ${controller.getQuestionsForQuiz(controller.quiz.idUQuiz).length}',
                      style: const TextStyle(fontSize: 18),
                    ),

                    //correct answer
                    Text(
                      'Jawaban Benar: ${controller.score.value}',
                      style: const TextStyle(fontSize: 18),
                    ),

                    //wrong answer
                    Text(
                      'Jawaban Salah: ${controller.getQuestionsForQuiz(controller.quiz.idUQuiz).length - controller.score.value}',
                      style: const TextStyle(fontSize: 18),
                    ),

                    Text(
                      'Tidak Dijawab: ${emptyAnswer()}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed('home');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                ),
                child: const Text(
                  'Menu Ujian',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int emptyAnswer() {
    int count = 0;
    controller.getQuestionsForQuiz(controller.quiz.idUQuiz).forEach((element) {
      if (element.userAnswerIndices == null) {
        count++;
      }
    });
    return count;
  }
}
