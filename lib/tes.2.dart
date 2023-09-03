import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var selectedIndices = <int>[];
  var selectedAnswers = <dynamic>[].obs;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'Apa ibukota Indonesia?',
      'answers': ['Jakarta', 'Surabaya', 'Bandung', 'Medan'],
      'correctIndex': [0],
    },
    {
      'question': 'Siapakah presiden pertama Indonesia?',
      'answers': [
        'Soeharto',
        'Soekarno',
        'Joko Widodo',
        'Megawati Soekarnoputri'
      ],
      'correctIndex': [1],
    },
    {
      'question': 'Berapa hasil dari 2 + 2?',
      'answers': ['2', '4', '6', '8'],
      'correctIndex': [1],
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
            child: Text('Tutup'),
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
}

class QuizPage extends StatelessWidget {
  final QuizController quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Page'),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check, size: 30, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // BUAT IKON WAKTU DAN JAMNYA
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 30),
                      SizedBox(width: 10),
                      Text(
                        '00:00',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  // BUAT sebuah card untuk indeks soal
                  Row(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${quizController.currentQuestionIndex.value + 1}/${quizController.questions.length}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => showBottomSheet(context),
                        icon: Icon(Icons.dashboard_outlined, size: 30),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => Text(
                quizController
                        .questions[quizController.currentQuestionIndex.value]
                    ['question'],
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => quizController.isMultipleChoice
                  ? Column(
                      children: [
                        ...((quizController.questions[quizController
                                .currentQuestionIndex
                                .value]['answers'] as List<List<dynamic>>)
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          String answer = entry.value[0];
                          bool isChecked =
                              quizController.selectedAnswers[index] ?? false;
                          return CheckboxListTile(
                            title: Text(answer),
                            value: isChecked,
                            onChanged: (value) {
                              quizController.selectedAnswers[index] =
                                  value ?? false;
                            },
                          );
                        })),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible:
                                  quizController.currentQuestionIndex.value > 0,
                              child: ElevatedButton(
                                onPressed: quizController.previousQuestion,
                                child: Text('Previous'),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ((quizController.questions[quizController
                                            .currentQuestionIndex.value]
                                        ['answers'] as List<List<dynamic>>)
                                    .forEach((answer) {
                                  quizController.selectedAnswers.add(answer[1]);
                                }));
                                quizController.checkAnswer(
                                    quizController.selectedAnswers);
                                quizController.nextQuestion();
                                ((quizController.questions[quizController
                                            .currentQuestionIndex.value]
                                        ['answers'] as List<List<dynamic>>)
                                    .forEach((answer) {
                                  answer[1] = false;
                                }));
                              },
                              child: Text('Next'),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        ...((quizController.questions[quizController
                                .currentQuestionIndex
                                .value]['answers'] as List<String>)
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          String answer = entry.value;
                          return Card(
                            color: Color.fromRGBO(217, 217, 217, 1),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: RadioListTile<int>(
                              title: Text(answer),
                              value: index,
                              groupValue:
                                  quizController.selectedIndices.isNotEmpty
                                      ? quizController.selectedIndices[0]
                                      : null,
                              onChanged: (int? value) {
                                quizController.selectedIndices = [value ?? -1];
                              },
                            ),
                          );
                        })),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible:
                                  quizController.currentQuestionIndex.value > 0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.2,
                                    50,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                onPressed: quizController.previousQuestion,
                                child: Icon(
                                  Icons.arrow_circle_left_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.7,
                                  50,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                if (quizController.currentQuestionIndex.value <
                                    quizController.questions.length - 1) {
                                  quizController.nextQuestion();
                                } else {
                                  quizController.nextQuestion();
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quizController.currentQuestionIndex.value <
                                          quizController.questions.length - 1
                                      ? Text(
                                          "Next",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Text(
                                          "Submit",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                  quizController.currentQuestionIndex.value <
                                          quizController.questions.length - 1
                                      ? Icon(
                                          Icons.arrow_circle_right_outlined,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.done_outline_rounded,
                                          color: Colors.white,
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Theme.of(context).primaryColor,
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'List Soal',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, //Jumlah kolom dalam grid
                ),
                itemCount: quizController.questions.length, //Jumlah nomor soal
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      //  Tindakan ketika nomor soal dipilih
                      Navigator.pop(context); //Tutup bottom sheet
                      //  Lakukan tindakan lain sesuai nomor soal yang dipilih
                    },
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color:
                              quizController.currentQuestionIndex.value == index
                                  ? Colors.green
                                  : Color.fromRGBO(217, 217, 217, 1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          (index + 1).toString(), // Tampilkan nomor soal
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        quizController.currentQuestionIndex.value = index;
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
