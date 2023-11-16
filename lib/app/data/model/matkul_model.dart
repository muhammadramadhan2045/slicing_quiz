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
  final String question;
  final String? image;
  final List<String> answers;
  final List<int> correctIndices;
  List<int>? userAnswerIndices;

  Question({
    required this.question,
    this.image,
    required this.answers,
    required this.correctIndices,
    this.userAnswerIndices,
  });
}

// models.dart


