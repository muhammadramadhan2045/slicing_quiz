// import 'package:flutter/material.dart';

// class QuizPage extends StatefulWidget {
//   const QuizPage({Key? key}) : super(key: key);

//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   int _currentQuestionIndex = 0;
//   int _score = 0;

//   List<Map<String, dynamic>> questions = [
//     {
//       'question': 'Apa ibukota Indonesia?',
//       'answers': ['Jakarta', 'Surabaya', 'Bandung', 'Medan'],
//       'correctIndex': 0,
//     },
//     {
//       'question': 'Siapakah presiden pertama Indonesia?',
//       'answers': [
//         'Soeharto',
//         'Soekarno',
//         'Joko Widodo',
//         'Megawati Soekarnoputri'
//       ],
//       'correctIndex': 1,
//     },
//     {
//       'question': 'Berapa hasil dari 2 + 2?',
//       'answers': ['2', '4', '6', '8'],
//       'correctIndex': 1,
//     },
//   ];

//   void _checkAnswer(int selectedIndex) {
//     if (selectedIndex == questions[_currentQuestionIndex]['correctIndex']) {
//       setState(() {
//         _score++;
//       });
//     }
//   }

//   void _nextQuestion() {
//     setState(() {
//       if (_currentQuestionIndex < questions.length - 1) {
//         _currentQuestionIndex++;
//       } else {
//         // Menampilkan dialog dengan skor kuis
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Kuis Selesai'),
//               content: Text('Skor Anda: $_score / ${questions.length}'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     // Reset kuis setelah selesai
//                     setState(() {
//                       _currentQuestionIndex = 0;
//                       _score = 0;
//                     });
//                     Navigator.pop(context);
//                   },
//                   child: Text('Tutup'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     });
//   }

//   void _previousQuestion() {
//     setState(() {
//       if (_currentQuestionIndex > 0) {
//         _currentQuestionIndex--;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz Page'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Pertanyaan ${_currentQuestionIndex + 1}/${questions.length}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               questions[_currentQuestionIndex]['question'],
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(height: 20),
//             ...(questions[_currentQuestionIndex]['answers'] as List<String>)
//                 .map((answer) {
//               return ElevatedButton(
//                 onPressed: () {
//                   _checkAnswer(questions[_currentQuestionIndex]['answers']
//                       .indexOf(answer));
//                   _nextQuestion();
//                 },
//                 child: Text(answer),
//               );
//             }).toList(),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Visibility(
//                   visible: _currentQuestionIndex >
//                       0, // Tampilkan tombol hanya jika bukan pertanyaan pertama
//                   child: ElevatedButton(
//                     onPressed: _previousQuestion,
//                     child: Text('Previous'),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _nextQuestion,
//                   child: Text('Next'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
