import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_getx/app/routes/app_pages.dart';

class QuizController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var selectedIndices = <int>[].obs;
  var selectedAnswers = <dynamic>[].obs;

  RxInt timeRemaining = 100.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  List<Map<String, dynamic>> questions = [
    {
      'question': 'Apa ibukota Indonesia?',
      'answers': ['Jakarta', 'Surabaya', 'Bandung', 'Medan'],
      'correctIndex': [0]
    },
    {
      'question': 'Siapakah presiden pertama Indonesia?',
      'answers': [
        'Soeharto',
        'Soekarno',
        'Joko Widodo',
        'Megawati Soekarnoputri'
      ],
      'correctIndex': [1]
    },
    {
      'question': 'Berapa hasil dari 2 + 2?',
      'answers': ['2', '4', '6', '8'],
      'correctIndex': [1]
    },
    {
      'question': 'Mana saja yang termasuk benua di dunia?',
      'answers': [
        ['Indonesia', false],
        ['Australia', false],
        ['Afrika', false],
        ['Jawa', false],
      ],
      'correctIndices': [1, 2],
    },
  ];

  bool get isMultipleChoice =>
      questions[currentQuestionIndex.value]['answers'] is List<List<dynamic>>;

  void checkAnswer(List<dynamic> selectedAnswers) {
    List<dynamic> correctAnswers =
        questions[currentQuestionIndex.value]['correctIndex'];

    if (selectedAnswers.length == correctAnswers.length &&
        selectedAnswers.every((answer) => correctAnswers.contains(answer))) {
      score.value++;
    }
  }

  void nextQuestion() {
    if (isMultipleChoice) {
      checkAnswer(selectedAnswers);
      selectedAnswers.clear();
    } else {
      if (selectedIndices.isNotEmpty) {
        int selectedAnswerIndex = selectedIndices[0];
        List<int> correctAnswerIndices =
            questions[currentQuestionIndex.value]['correctIndex'];

        if (correctAnswerIndices.contains(selectedAnswerIndex)) {
          score.value++;
        }
      }
      selectedIndices.clear();
    }

    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    } else {
      showExitQuizDialog();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  void showExitQuizDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              child: const Text(
                'Konfirmasi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Apakah Anda yakin ingin menyudahi ujian?'),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue,
                    fixedSize: Size(Get.width * 0.3, 50),
                  ),
                  child: const Text('Tidak'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedIndices.isNotEmpty) {
                      int selectedAnswerIndex = selectedIndices[0];
                      List<int> correctAnswerIndices =
                          questions[currentQuestionIndex.value]['correctIndex'];

                      if (correctAnswerIndices.contains(selectedAnswerIndex)) {
                        score.value++;
                      }
                    }
                    selectedIndices.clear();
                    stopTimer();
                    Get.toNamed(Routes.RESULT); // Pindah ke halaman hasil
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue,
                    fixedSize: Size(Get.width * 0.3, 50),
                  ),
                  child: const Text('Ya'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void stopTimer() {
    timer?.cancel();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (timer) {
        if (timeRemaining.value == 0) {
          timer.cancel();
          Get.snackbar(
            'Waktu Habis',
            'Waktu Anda telah habis',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.all(16),
            borderRadius: 10,
            duration: const Duration(seconds: 3),
          );
          Get.toNamed(Routes.RESULT);
        } else {
          timeRemaining.value--;
        }
      },
    );
  }

  String getFormatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesString = minutes.toString().padLeft(2, '0');
    String secondsString = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesString:$secondsString';
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
