import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/auth/log_in.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naviation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        // navigationBarTheme: const NavigationBarThemeData(
        //   labelTextStyle: TextStyle(color: Colors.white),
        // ),
      ),
      home: Login(),
    );
  }
}

void main() {
  runApp(const MyApp());
}
