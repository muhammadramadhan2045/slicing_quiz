import 'package:flutter/material.dart';
import 'package:quiz/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff0f497a),
        // colorScheme: ColorScheme.fromSwatch(
        //   backgroundColor: Colors.white,
        //   primarySwatch: Colors.grey,
        // ),
        useMaterial3: true,
      ),
      home: const FirsPage(),
    );
  }
}
