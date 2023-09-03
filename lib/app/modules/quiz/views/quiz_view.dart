import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'QuizView rebuild :${controller.questions[controller.currentQuestionIndex.value]['question']}');
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
            onPressed: () {},
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
                  const Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 30),
                      SizedBox(width: 10),
                      Text(
                        '00:00',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${controller.currentQuestionIndex.value + 1}/${controller.questions.length}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => showBottomSheet(context),
                          icon: const Icon(Icons.dashboard_outlined, size: 30),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(
                () => Text(
                  controller.questions[controller.currentQuestionIndex.value]
                      ['question'],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => controller.isMultipleChoice
                    ? Column(
                        children: [
                          ...((controller.questions[controller
                                  .currentQuestionIndex
                                  .value]['answers'] as List<List<dynamic>>)
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            String answer = entry.value[0];
                            bool isChecked = entry.value[1];
                            return CheckboxListTile(
                              title: Text(answer),
                              value: isChecked,
                              onChanged: (value) {
                                controller.selectedAnswers[index] = value;
                              },
                            );
                          })),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible:
                                    controller.currentQuestionIndex.value > 0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.previousQuestion();
                                  },
                                  child: const Text('Previous'),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller
                                      .checkAnswer(controller.selectedAnswers);
                                  controller.nextQuestion();
                                  controller.selectedAnswers.assignAll(
                                      List.filled(
                                          controller.selectedAnswers.length,
                                          false));
                                },
                                child: const Text('Next'),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          ...((controller.questions[controller
                                  .currentQuestionIndex
                                  .value]['answers'] as List<String>)
                              .asMap()
                              .entries
                              .map(
                            (entry) {
                              int index = entry.key;
                              String answer = entry.value;
                              return Card(
                                color: const Color.fromRGBO(217, 217, 217, 1),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RadioListTile<int>(
                                  title: Text(answer),
                                  value: index,
                                  groupValue:
                                      controller.selectedIndices.isNotEmpty
                                          ? controller.selectedIndices[0]
                                          : null,
                                  onChanged: (int? value) {
                                    controller.selectedIndices
                                        .assignAll([value ?? -1]);
                                  },
                                ),
                              );
                            },
                          )),
                          SizedBox(height: 20),
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
                                      controller.questions.length - 1) {
                                    controller.nextQuestion();
                                  } else {
                                    controller
                                        .showExitQuizDialog(); // Tampilkan dialog konfirmasi
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    controller.currentQuestionIndex.value <
                                            controller.questions.length - 1
                                        ? const Text(
                                            "Next",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        : const Text(
                                            "Submit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                    controller.currentQuestionIndex.value <
                                            controller.questions.length - 1
                                        ? const Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Colors.white,
                                          )
                                        : const Icon(
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
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
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
              padding: const EdgeInsets.all(10),
              child: const Text(
                'List Soal',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // Jumlah kolom dalam grid
                ),
                itemCount: controller.questions.length, // Jumlah nomor soal
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      //  Tindakan ketika nomor soal dipilih
                      Navigator.pop(context); // Tutup bottom sheet
                      controller.currentQuestionIndex.value =
                          index; // Ganti pertanyaan saat dipilih
                    },
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: controller.currentQuestionIndex.value == index
                              ? Colors.green
                              : const Color.fromRGBO(217, 217, 217, 1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          (index + 1).toString(), // Tampilkan nomor soal
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
}
