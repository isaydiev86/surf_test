import 'package:flutter/material.dart';
import 'package:surf_test/pages/login_page.dart';
import 'package:surf_test/resources/surftest_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

