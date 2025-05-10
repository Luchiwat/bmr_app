import 'package:flutter_bmr_app/views/bmr_home_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMRApp extends StatefulWidget {
  const BMRApp({super.key});

  @override
  State<BMRApp> createState() => _BMRAppState();
}
void main() {
  runApp(
      //เรียกใช้คลาสที่เรียกใช้วิดเจตหลักของแอป meterialApp()
      BMRApp());
}
class _BMRAppState extends State<BMRApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeUI(),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme
        )
      ),
    );
  }
}