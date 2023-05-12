import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'auth/log_in.dart';
import '../components/nav.dart';

import '../components/tool_cards.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

GlobalKey<ActivityCardState> homeKey = GlobalKey<ActivityCardState>();

class Home extends StatefulWidget {
  final GoogleSignInAccount user;

  Home({Key? key, required this.user}) : super(key: key);

  static GlobalKey<ActivityCardState> getKey() {
    return homeKey;
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/spreadsheets',
  ]);

  int _counter = 0;

  _MyHomePageState() {
  }

  final _spreadsheetId = '1JF3wS10ayFZISBne_MuluZb0MkV-fzrJWAcGdgN4_N8';
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            // margin: const EdgeInsets.all(10.0),
            // color: Color(0xFF80838B),
            width: MediaQuery.of(context).size.width,
            height: 140.0,

            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF80838B),
                ),
                color: Color(0xFF80838B),
                borderRadius: BorderRadius.all(Radius.circular(10))),

            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 60, 10, 10),
              // color: Color(0xFF4F525A),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF4F525A),
                  ),
                  color: Color(0xFF4F525A),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text('Status: Signed In',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 24,
                    )),
              ),
            ),
          ),
          ActivityCard(key: homeKey)
        ],
      ),
    );
  }
}
