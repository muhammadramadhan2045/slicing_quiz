/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<int> _selectedIndices = [];
  List<dynamic> selectedAnswers = [];

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
    // {
    //   'question': 'Mana saja yang termasuk benua di dunia?',
    //   'answers': [
    //     ['Indonesia', f  alse],
    //     ['Australia', false],
    //     ['Afrika', false],
    //     ['Jawa', false],
    //   ],
    //   'correctIndices': [1, 2],
    // },
  ];

  bool get isMultipleChoice =>
      questions[_currentQuestionIndex]['answers'] is List<List<dynamic>>;

  void _checkAnswer(List<dynamic> selectedAnswers) {
    List<dynamic> correctAnswers =
        questions[_currentQuestionIndex]['correctIndex'];

    if (listEquals(correctAnswers, selectedAnswers)) {
      setState(() {
        _score++;
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      if (isMultipleChoice) {
        _checkAnswer(selectedAnswers);
        selectedAnswers.clear();
      } else {
        if (_selectedIndices.isNotEmpty) {
          int selectedAnswerIndex = _selectedIndices[0];
          List<int> correctAnswerIndices =
              questions[_currentQuestionIndex]['correctIndex'];

          if (correctAnswerIndices.contains(selectedAnswerIndex)) {
            _score++;
          }
        }
        _selectedIndices.clear();
      }

      if (_currentQuestionIndex < questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Kuis Selesai'),
              content: Text('Skor Anda: $_score / ${questions.length}'),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentQuestionIndex = 0;
                      _score = 0;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Tutup'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check, size: 30),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //BUAT IKON WAKTU DAN JAMNYA
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
                //BUAT sebuah card untuk indeks soal
                Row(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${_currentQuestionIndex + 1}/${questions.length}',
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
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              questions[_currentQuestionIndex]['question'],
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            isMultipleChoice
                ? Column(
                    children: [
                      ...((questions[_currentQuestionIndex]['answers']
                              as List<List<dynamic>>)
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
                            setState(() {
                              questions[_currentQuestionIndex]['answers'][index]
                                  [1] = value ?? false;
                            });
                          },
                        );
                      })),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: _currentQuestionIndex > 0,
                            child: ElevatedButton(
                              onPressed: _previousQuestion,
                              child: const Text('Previous'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ((questions[_currentQuestionIndex]['answers']
                                      as List<List<dynamic>>)
                                  .forEach((answer) {
                                selectedAnswers.add(answer[1]);
                              }));
                              _checkAnswer(selectedAnswers);
                              _nextQuestion();
                              ((questions[_currentQuestionIndex]['answers']
                                      as List<List<dynamic>>)
                                  .forEach((answer) {
                                answer[1] = false;
                              }));
                            },
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      ...((questions[_currentQuestionIndex]['answers']
                              as List<String>)
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        String answer = entry.value;
                        return Card(
                          color: const Color.fromRGBO(217, 217, 217, 1),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: RadioListTile<int>(
                            title: Text(answer),
                            value: index,
                            groupValue: _selectedIndices.isNotEmpty
                                ? _selectedIndices[0]
                                : null,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedIndices = [value ?? -1];
                              });
                            },
                          ),
                        );
                      })),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: _currentQuestionIndex > 0,
                            child: ElevatedButton(
                              onPressed: _previousQuestion,
                              child: Text('Previous'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_currentQuestionIndex <
                                  questions.length - 1) {
                                _nextQuestion();
                              } else {
                                _nextQuestion();
                              }
                            },
                            child: Text(
                                _currentQuestionIndex < questions.length - 1
                                    ? 'Next'
                                    : 'Submit'),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      constraints:,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pilih Nomor Soal',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 200, // Tinggi GridView
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // Jumlah kolom dalam grid
                ),
                itemCount: questions.length, // Jumlah nomor soal
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Tindakan ketika nomor soal dipilih
                      Navigator.pop(context); // Tutup bottom sheet
                      // Lakukan tindakan lain sesuai nomor soal yang dipilih
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        (index + 1).toString(), // Tampilkan nomor soal
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
  // Widget soalBottomSheet() {
  //   return BottomSheet(
  //     onClosing: () {
  //       Navigator.pop(context);
  //     },
  //     clipBehavior: Clip.antiAliasWithSaveLayer,
  //     builder: (context) {
  //       return Container(
  //         height: 200,
  //         child: Column(
  //           children: [
  //             Container(
  //               width: double.infinity,
  //               padding: const EdgeInsets.all(16.0),
  //               color: Colors.blue,
  //               child: const Text(
  //                 'Judul Bottom Sheet',
  //                 style: TextStyle(
  //                   fontSize: 20.0,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             Expanded(
  //               child: ListView.builder(
  //                 itemCount: questions.length,
  //                 itemBuilder: (context, index) {
  //                   return ListTile(
  //                     title: Text('Soal ${index + 1}'),
  //                     onTap: () {
  //                       setState(() {
  //                         _currentQuestionIndex = index;
  //                       });
  //                       Navigator.pop(context);
  //                     },
  //                   );
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}

 */