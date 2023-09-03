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
    //  {
    //    'question': 'Mana saja yang termasuk benua di dunia?',
    //    'answers': [
    //      ['Indonesia', false],
    //      ['Australia', false],
    //      ['Afrika', false],
    //      ['Jawa', false],
    //    ],
    //    'correctIndices': [1, 2],
    //  },
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BUAT IKON WAKTU DAN JAMNYA
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
                // BUAT sebuah card untuk indeks soal
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: _currentQuestionIndex > 0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.2,
                                  50,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              onPressed: _previousQuestion,
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
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                if (_currentQuestionIndex <
                                    questions.length - 1) {
                                  _nextQuestion();
                                } else {
                                  _nextQuestion();
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _currentQuestionIndex < questions.length - 1
                                      ? const Text(
                                          "Next",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : const Text(
                                          "Submit",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                  _currentQuestionIndex < questions.length - 1
                                      ? const Icon(
                                          Icons.arrow_circle_right_outlined,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.done_outline_rounded,
                                          color: Colors.white,
                                        ),
                                ],
                              )),
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
            Container(
              height: 200,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, //Jumlah kolom dalam grid
                ),
                itemCount: questions.length, //Jumlah nomor soal
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
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: _currentQuestionIndex == index
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
                        setState(() {
                          _currentQuestionIndex = index;
                        });
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
