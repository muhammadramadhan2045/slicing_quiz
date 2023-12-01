class MataKuliah {
  final String idMataKuliah;
  final String namaMataKuliah;

  MataKuliah({required this.idMataKuliah, required this.namaMataKuliah});
}

class Quiz {
  final String idUQuiz;
  final String idMataKuliah;
  final String namaQuiz;
  final DateTime tanggalQuiz;
  final int durasiPengerjaan;

  Quiz({
    required this.idUQuiz,
    required this.idMataKuliah,
    required this.namaQuiz,
    required this.tanggalQuiz,
    required this.durasiPengerjaan,
  });
}

class Question {
  final String idQuiz;
  final String question;
  final String? image;
  final List<String> answers;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? optionE;
  final List<int> correctIndex;
  List<int>? userAnswerIndices;

  Question({
    required this.idQuiz,
    required this.question,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.optionE,
    this.image,
    required this.answers,
    required this.correctIndex,
    this.userAnswerIndices,
  });
}

// models.dart


