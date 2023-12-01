import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_getx/app/data/model/matkul_model.dart';

import '../../../routes/app_pages.dart';
import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Question> questions =
        controller.getQuestionsForQuiz(controller.quiz.idUQuiz);
    for (int i = 0; i < questions.length; i++) {
      print("ini" + questions[i].question);
      print("ini" + questions[i].answers.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () => showExitQuizDialog(context),
            icon: const Icon(Icons.check, size: 30, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sisa Waktu",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => Text(
                          controller
                              .getFormatTime(controller.timeRemaining.value),
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Text(
                          '${controller.currentQuestionIndex.value + 1}/${questions.length}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showBottomSheet(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.dashboard_outlined,
                                    size: 20,
                                    color: Theme.of(context).primaryColor),
                                Text(
                                  'List Soal',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Obx(
                () => Text(
                  questions[controller.currentQuestionIndex.value].question,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => controller.isMultipleChoice
                    ? Column(
                        children: [
                          ...((questions[controller.currentQuestionIndex.value]
                                  .answers)
                              .asMap()
                              .entries
                              .map(
                            (entry) {
                              int index = entry.key;
                              debugPrint('index: $index');
                              String answer = entry.value;
                              return Card(
                                color: const Color.fromRGBO(217, 217, 217, 1),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: CheckboxListTile(
                                  title: Text(answer),
                                  value: controller.selectedAnswers[index],
                                  selected: controller.selectedAnswers[index],
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  subtitle: const Text('Pilih Jawaban'),
                                  onChanged: (value) {
                                    controller.selectedAnswers[index] =
                                        value ?? false;
                                    debugPrint(
                                        'selectedAnswers: ${controller.selectedAnswers}');
                                    controller.update();
                                  },
                                ),
                              );
                            },
                          )),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible:
                                    controller.currentQuestionIndex.value > 0,
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
                                  onPressed: () {
                                    controller.previousQuestion();
                                  },
                                  child: const Icon(
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
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  if (controller.currentQuestionIndex.value <
                                      questions.length - 1) {
                                    controller.selectedAnswers.assignAll(
                                        List.filled(
                                            controller.selectedAnswers.length,
                                            false));
                                    controller.nextQuestion();
                                  } else {
                                    showExitQuizDialog(context);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    controller.currentQuestionIndex.value <
                                            questions.length - 1
                                        ? const Text(
                                            "Selanjutnya",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        : const Text(
                                            "Submit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                    const SizedBox(width: 10),
                                    controller.currentQuestionIndex.value <
                                            questions.length - 1
                                        ? const Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.done_outline_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          if (questions[controller.currentQuestionIndex.value]
                                  .image !=
                              null)
                            Image.network(
                              questions[controller.currentQuestionIndex.value]
                                  .image!,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                          ...((questions[controller.currentQuestionIndex.value]
                                  .answers)
                              .asMap()
                              .entries
                              .map(
                            (entry) {
                              int index = entry.key;
                              String answer = entry.value;
                              debugPrint('index: $index');
                              return Card(
                                color: Colors.white,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color:
                                        controller.selectedIndices.isNotEmpty &&
                                                controller.selectedIndices[0] ==
                                                    index
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: RadioListTile<int>(
                                  title: Text(answer),
                                  value: index,
                                  groupValue: controller
                                          .selectedIndices.isNotEmpty
                                      ? controller.selectedIndices[0]
                                      : controller.selectedIndicesTemp.length >
                                              controller
                                                  .currentQuestionIndex.value
                                          ? controller.selectedIndicesTemp[
                                              controller
                                                  .currentQuestionIndex.value]
                                          : null,
                                  onChanged: (int? value) {
                                    controller.selectedIndices
                                        .assignAll([value ?? -1]);
                                    controller.update();
                                  },
                                ),
                              );
                            },
                          )),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible:
                                    controller.currentQuestionIndex.value > 0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.45,
                                      50,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    controller.previousQuestion();
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_circle_left_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Kembali",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.45,
                                    50,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  if (controller.currentQuestionIndex.value <
                                      questions.length - 1) {
                                    controller.nextQuestion();
                                  } else {
                                    showExitQuizDialog(
                                        context); // Tampilkan dialog konfirmasi
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    controller.currentQuestionIndex.value <
                                            questions.length - 1
                                        ? const Text(
                                            "Selanjutnya",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : const Text(
                                            "Submit",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                    const SizedBox(width: 10),
                                    controller.currentQuestionIndex.value <
                                            questions.length - 1
                                        ? const Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.done_outline_rounded,
                                            color: Colors.white,
                                            size: 20,
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
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    debugPrint(
        'ini showBottomSheet ${controller.getQuestionsForQuiz(controller.quiz.idUQuiz.toString()).length}');
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      elevation: 10.0,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              child: const Text(
                'List Soal',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: controller
                    .getQuestionsForQuiz(controller.quiz.idUQuiz)
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      controller.currentQuestionIndex.value = index;
                    },
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: controller.selectedIndicesTemp[index] != -1
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          (index + 1).toString(), // Tampilkan nomor sosubal
                          style: TextStyle(
                            color: controller.selectedIndicesTemp[index] != -1
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        controller.currentQuestionIndex.value = index;
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

  void showExitQuizDialog(BuildContext context) {
    Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      backgroundColor: Colors.white,
      Container(
        padding: const EdgeInsets.all(16),
        height: Get.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Yakin ingin kumpulkan sekarang?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Total soal: ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: controller
                            .getQuestionsForQuiz(
                                controller.quiz.idUQuiz.toString())
                            .length
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Text.rich(
                    TextSpan(
                      text: 'Sisa waktu: ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: controller
                              .getFormatTime(controller.timeRemaining.value),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                      side: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    fixedSize: const Size(150, 50),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    'Kembali',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.selectedIndices.isNotEmpty) {
                      int selectedAnswerIndex = controller.selectedIndices[0];
                      List<int> correctAnswerIndices = controller
                          .getQuestionsForQuiz(controller.quiz.idUQuiz)[
                              controller.currentQuestionIndex.value]
                          .correctIndex;
                      controller.selectedIndicesTemp[controller
                          .currentQuestionIndex
                          .value] = controller.selectedIndices[0];
                      debugPrint(
                          "selectedIndicesTemp: $controller.selectedIndicesTemp");

                      if (correctAnswerIndices.contains(selectedAnswerIndex)) {
                        controller.score.value++;
                      }
                    }
                    //update question temp
                    if (controller.selectedIndices.isNotEmpty) {
                      controller
                          .questions_temp[controller.currentQuestionIndex.value]
                          .userAnswerIndices = controller.selectedIndices;
                    }
                    // selectedIndices.clear();
                    controller.stopTimer();
                    Get.toNamed(Routes.RESULT); // Pindah ke halaman hasil
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    fixedSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Kumpulkan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
