import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/ui/home_screen.dart';

import 'constants/custom_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: CustomColors.customBlue
        )
      ),
      home:  const HomeScreen(),
    );
  }
}
