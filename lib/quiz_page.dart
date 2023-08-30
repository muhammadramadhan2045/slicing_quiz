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
    // {
    //   'question': 'Berapa hasil dari 2 + 2?',
    //   'answers': ['2', '4', '6', '8'],
    //   'correctIndex': [1],
    // },
    // {
    //   'question': 'Mana saja yang termasuk benua di dunia?',
    //   'answers': [
    //     ['Indonesia', false],
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
              title: Text('Kuis Selesai'),
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
                  child: Text('Tutup'),
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
        title: Text('Quiz Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pertanyaan ${_currentQuestionIndex + 1}/${questions.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 20),
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
                        return RadioListTile<int>(
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
                            onPressed: _nextQuestion,
                            child: Text('Next'),
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
}
