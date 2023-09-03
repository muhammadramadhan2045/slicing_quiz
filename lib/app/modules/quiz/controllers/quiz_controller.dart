import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var selectedIndices = <int>[].obs;
  var selectedAnswers = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
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
      Get.defaultDialog(
        title: 'Kuis Selesai',
        content: Text('Skor Anda: ${score.value} / ${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              currentQuestionIndex.value = 0;
              score.value = 0;
              Get.back();
            },
            child: const Text('Tutup'),
          ),
        ],
      );
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  void showExitQuizDialog() {
    Get.defaultDialog(
      title: 'Konfirmasi',
      middleText: 'Apakah Anda yakin ingin menyudahi ujian?',
      actions: [
        ElevatedButton(
          onPressed: () {
            // Get.offAll(ResultPage()); // Pindah ke halaman hasil
          },
          child: const Text('Ya'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Tidak'),
        ),
      ],
    );
  }
}
