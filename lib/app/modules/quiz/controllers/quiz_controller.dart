import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_getx/app/data/model/matkul_model.dart';
import 'package:quiz_getx/app/routes/app_pages.dart';

class QuizController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var selectedIndices = <int>[].obs;
  var selectedIndicesTemp = <int>[].obs;
  var selectedAnswers = <bool>[].obs;
  var quiz = Get.arguments as Quiz;
  var showQuitDialog = false.obs;

  RxInt timeRemaining = RxInt(Get.arguments.durasiPengerjaan);
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
    questions_temp = qustions;
    //jadikan panjang array sesuai dengan jumlah soal
    for (int i = 0;
        i <
            qustions.where((element) {
              return element.idQuiz == quiz.idUQuiz.toString();
            }).length;
        i++) {
      selectedIndicesTemp.add(-1);
    }

    selectedAnswers = List.generate(
      getQuestionsForQuiz(quiz.idUQuiz.toString())[currentQuestionIndex.value]
          .answers
          .length,
      (index) => false,
    ).obs;
    debugPrint("selectedAnswers: $selectedAnswers");
  }

  // List<Map<String, dynamic>> questions = [
  //   {
  //     'question': 'Apa ibukota Indonesia?',
  //     'image': 'https://imgpile.com/images/CEbjmW.md.jpg',
  //     'answers': ['Jakarta', 'Surabaya', 'Bandung', 'Medan'],
  //     'correctIndex': [0],
  //     'user_answer': null,
  //   },
  //   {
  //     'question': 'Siapakah presiden pertama Indonesia?',
  //     'answers': [
  //       'Soeharto',
  //       'Soekarno',
  //       'Joko Widodo',
  //       'Megawati Soekarnoputri'
  //     ],
  //     'correctIndex': [1],
  //     'user_answer': null,
  //   },
  //   {
  //     'question': 'Berapa hasil dari 2 + 2?',
  //     'answers': ['2', '4', '6', '8'],
  //     'correctIndex': [1],
  //     'user_answer': null,
  //   },
  //   {
  //     'question': 'Berapa hasil dari 2 + 2?',
  //     'answers': ['2', '4', '6', '8'],
  //     'correctIndex': [1],
  //     'user_answer': null,
  //   },
  //   // {
  //   //   'question': 'Mana saja yang termasuk benua di dunia?',
  //   //   'answers': [
  //   //     ['Indonesia', false],
  //   //     ['Australia', false],
  //   //     ['Afrika', false],
  //   //     ['Jawa', false],
  //   //   ],
  //   //   'correctIndices': [1, 2],
  //   // },
  // ];

  List<Question> qustions = [
    Question(
      idQuiz: '1',
      question: 'Apa ibukota Indonesia?',
      image: 'https://imgpile.com/images/CEbjmW.md.jpg',
      answers: ['Jakarta', 'Surabaya', 'Bandung', 'Medan'],
      correctIndex: [0],
    ),
    Question(
      idQuiz: '1',
      question: 'Siapakah presiden pertama Indonesia?',
      answers: [
        'Soeharto',
        'Soekarno',
        'Joko Widodo',
        'Megawati Soekarnoputri'
      ],
      correctIndex: [1],
    ),
    Question(
      idQuiz: '1',
      question: 'Berapa hasil dari 2 + 2?',
      answers: ['2', '4', '6', '8'],
      correctIndex: [1],
    ),
    Question(
      idQuiz: '1',
      question: 'Tes 4 * 5?',
      answers: ['2', '40', '20', '9'],
      correctIndex: [2],
    ),
    Question(
      idQuiz: '1',
      question: 'Tes 4 * 5?',
      answers: ['2', '40', '20', '9'],
      correctIndex: [2],
    ),
    Question(
      idQuiz: '1',
      question: 'Tes 4 * 5?',
      answers: ['2', '40', '20', '9'],
      correctIndex: [2],
    ),
    Question(
      idQuiz: '1',
      question: 'Tes 4 * 5?',
      answers: ['2', '40', '20', '9'],
      correctIndex: [2],
    ),
    Question(
      idQuiz: '1',
      question: 'Tes 4 * 5?',
      answers: ['2', '40', '20', '9'],
      correctIndex: [2],
    ),
    Question(
      idQuiz: '2',
      question: 'Berapa hasil dari 10 * 10?',
      answers: ['120', '240', '100', '99'],
      correctIndex: [2],
    ),
    Question(
      idQuiz: '2',
      question: 'Berapa hasil dari 10 * 10?',
      answers: ['120', '240', '100', '99'],
      correctIndex: [2],
    ),
    Question(
      idQuiz: '2',
      question: 'Nama Benua Di Dunia?',
      answers: ['Asia', 'Eropa', 'Afrika Selatan', 'Amerika'],
      correctIndex: [1, 2, 3],
    ),
    Question(
      idQuiz: '3',
      question: 'Berapa hasil dari 10 * 10?',
      optionA: '10',
      optionB: '20',
      optionC: '100',
      optionD: '40',
      answers: ['120', '240', '100', '99'],
      correctIndex: [2],
    ),
    Question(
      idQuiz: '4',
      question: 'Berapa hasil dari 10 * 11?',
      answers: ['120', '240', '100', '110'],
      correctIndex: [3],
    ),
    Question(
      idQuiz: '4',
      question: 'Berapa hasil dari 120 * 10?',
      answers: ['1200', '240', '100', '99'],
      correctIndex: [0],
    ),
  ].obs;

  // Fungsi untuk mendapatkan daftar soal berdasarkan idquiz
  List<Question> getQuestionsForQuiz(String idQuiz) {
    return qustions.where((element) {
      return element.idQuiz == quiz.idUQuiz;
    }).toList();
  }

  List<Question> questions_temp = [];

  bool get isMultipleChoice =>
      getQuestionsForQuiz(quiz.idUQuiz.toString())[currentQuestionIndex.value]
          .correctIndex
          .length >
      1;

  // void updateAnswerStatus(int questionIndex, int answerIndex, bool value) {
  //   qustions[questionIndex]['answers'][answerIndex][1] = value;
  //   debugPrint("questions: $questions");
  // }

  bool hasChangedFromCorrect =
      false; // Variable untuk melacak perubahan dari jawaban yang benar

/* kode pertama
  void checkAnswer(List<dynamic> selectedAnswers) {
    List<dynamic> correctAnswers =
        questions[currentQuestionIndex.value]['correctIndex'];

    if (selectedAnswers.length == correctAnswers.length &&
        selectedAnswers.every((answer) => correctAnswers.contains(answer))) {
      score++;
    } else {
      //jika sebelumnya memilih jawaban benar , kmudian mengganti menjadi salah maka kurangi score dan jika sebelumnya telah memilih jawaban salah maka tidak perlu dikurangi score
      if (selectedIndicesTemp.length > currentQuestionIndex.value) {
        if (selectedIndicesTemp[currentQuestionIndex.value] ==
            correctAnswers[0]) {
          score.value++;
        } else {
          if (score.value > 0 &&
              selectedIndicesTemp[currentQuestionIndex.value] !=
                  correctAnswers[0]) {
            score.value --;
            //if sebelumnya memilih jawaban salah maka tidak perlu dikurangi score
          } else {
            if (score.value > 0) {
              score.value--;
            } else {
              score.value += 0;
            }
          }
        }
      }
    }
    debugPrint("selectedIndices score now : ${score.value}");
    // debugPrint("selected_correctAnswers: $correctAnswers");
  }

 */
  void checkAnswer(List<dynamic> selectedAnswers) {
    List<dynamic> correctAnswers =
        getQuestionsForQuiz(quiz.idUQuiz.toString())[currentQuestionIndex.value]
            .correctIndex;
    debugPrint("selected correctAnswers: $correctAnswers");

    if (selectedAnswers.length == correctAnswers.length &&
        selectedAnswers.every((answer) => correctAnswers.contains(answer))) {
      // Jawaban benar
      score.value++;
    } else {
      if (selectedIndicesTemp.length > currentQuestionIndex.value) {
        int previousAnswer = selectedIndicesTemp[currentQuestionIndex.value];

        if (previousAnswer == correctAnswers[0]) {
          // Sebelumnya memilih jawaban benar, dan sekarang salah
          score.value--;
        } else {
          // Sebelumnya memilih jawaban salah, tidak ada pengurangan skor
          score.value += 0;
        }
      }
    }

    debugPrint("selectedIndices score now: ${score.value}");
  }

  void nextQuestion() {
    if (isMultipleChoice) {
      // checkAnswer(selectedAnswers);
      // selectedAnswers.clear();
    } else {
      if (selectedIndices.isNotEmpty) {
        selectedIndicesTemp[currentQuestionIndex.value] = selectedIndices[0];

        debugPrint("selectedIndicesTemp: $selectedIndicesTemp");

        //update question temp
        questions_temp[currentQuestionIndex.value].userAnswerIndices =
            selectedIndices;

        checkAnswer(selectedIndices);
        debugPrint("selectedIndices: $selectedIndices");
      }
      selectedIndices.clear();
    }

    if (currentQuestionIndex.value <
        getQuestionsForQuiz(quiz.idUQuiz).length - 1) {
      currentQuestionIndex.value++;
    }
  }

  void previousQuestion() {
    if (isMultipleChoice) {
      checkAnswer(selectedAnswers);
      // selectedAnswers.clear();
    } else {
      if (selectedIndices.isNotEmpty) {
        //jika pada nomor soal yang sama maka update jawban,kemdian jika pindah nomor soal maka tambahkan jawaban
        if (selectedIndicesTemp.length > currentQuestionIndex.value) {
          selectedIndicesTemp[currentQuestionIndex.value] = selectedIndices[0];
        } else {
          selectedIndicesTemp.add(selectedIndices[0]);
        }
        debugPrint("selectedIndicesTemp: $selectedIndicesTemp");

        //update question temp
        questions_temp[currentQuestionIndex.value].userAnswerIndices =
            selectedIndices;

        checkAnswer(selectedIndices);
        debugPrint("selectedIndices: $selectedIndices");
      }
      selectedIndices.clear();
    }
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
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
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursString = hours.toString().padLeft(2, '0');
    String minutesString = minutes.toString().padLeft(2, '0');
    String secondsString = remainingSeconds.toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hoursString:$minutesString:$secondsString';
    } else {
      return '$minutesString:$secondsString';
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
