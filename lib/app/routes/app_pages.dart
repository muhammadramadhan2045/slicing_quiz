import 'package:get/get.dart';
import 'package:quiz_getx/app/modules/home/views/pickquiz_view_view.dart';
import 'package:quiz_getx/app/modules/quiz/views/result_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PICKQUIZVIEWVIEW,
      page: () => const PickquizViewView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => const QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.RESULT,
      page: () => const ResultView(),
      binding: QuizBinding(),
    ),
  ];
}
