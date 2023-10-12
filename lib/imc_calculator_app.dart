import 'package:dio_dart_flutter_calculadora_imc/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IMCCalculatorApp extends StatelessWidget {
  const IMCCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // useMaterial3: true,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          sliderTheme: const SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
          ),
          snackBarTheme: const SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
              contentTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          primaryColor: Colors.deepPurple,
          textTheme: GoogleFonts.interTextTheme()),
      home: const HomePage(),
    );
  }
}
