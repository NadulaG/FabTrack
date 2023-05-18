import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64Url, utf8;

import 'auth/log_in.dart';
import '../components/nav.dart';

import '../components/tool_cards.dart';
import 'package:fabtrack/globals.dart';

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

class Home extends StatefulWidget {
  final GoogleSignInAccount user;

  const Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

void sheetsRequest() async {}

class _HomeState extends State<Home> {
  _MyHomePageState() {}

  final _spreadsheetId = '1JF3wS10ayFZISBne_MuluZb0MkV-fzrJWAcGdgN4_N8';
  int selectedPageIndex = 0;

  void logRequest() async {
    final List<String> parts = await widget.user.authentication.then((auth) => auth.idToken!.split('.'));
    if (parts.length != 3) {
      return null;
    }
    // retrieve token payload
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    // convert to Map
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    print(payloadMap["given_name"]);

    final http.Response timesheet = await http.get(
      Uri.parse(
          'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/Timesheet!A1:Z1000'),
      headers: await widget.user.authHeaders,
    );

    final http.Response training = await http.get(
      Uri.parse(
          'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/Training!A1:Z1000'),
      headers: await widget.user.authHeaders,
    );

    if (timesheet.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(timesheet.body);
      int newRow = data.values.elementAt(2).length + 1;

      final http.Response signIn = await http.put(
          Uri.parse(
              'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/Timesheet!A$newRow:B$newRow?valueInputOption=RAW'),
          headers: await widget.user.authHeaders,
          body: json.encode({
            "range": "Timesheet!A$newRow:B$newRow",
            "majorDimension": "ROWS",
            "values": [
              [widget.user.displayName, DateTime.now().toString()]
            ]
          }));

      if (signIn.statusCode == 200) {
        print('Signed in');
      } else {
        print(signIn.body);
      }
    } else {
      print(timesheet.body);
    }

    if (training.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(training.body);
      print(data);
    } else {
      print(training.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    logRequest();

    widget.user.authentication.then((value) => print("id token " + value.idToken.toString()));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 140.0,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF80838B),
              ),
              color: const Color(0xFF80838B),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 60, 10, 10),
            // color: Color(0xFF4F525A),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF4F525A),
                ),
                color: const Color(0xFF4F525A),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text('Status: Signed Out',
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
        // [{"name": "hammer", "skill level":1}, {"name": "hacksaw", "skill level":50}]
        ActivityCard(globalTools)
      ],
    );
  }
}
