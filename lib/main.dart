import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'pages/auth/log_in.dart';

class FabTrack extends StatelessWidget {
  const FabTrack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naviation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const Login(),
    );
  }
}

void main() {
  runApp(const FabTrack());
}
