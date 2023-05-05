import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'auth/log_in.dart';

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
  final String title;

  Home({Key? key, required this.title, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState(title: title, user: user);
}

class _HomeState extends State<Home> {
  final GoogleSignInAccount user;
  final String title;

  _HomeState({Key? key, required this.title, required this.user});

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/spreadsheets',
  ]);

  final _spreadsheetId = '1JF3wS10ayFZISBne_MuluZb0MkV-fzrJWAcGdgN4_N8';
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(79, 82, 90, 1),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color.fromARGB(255, 36, 36, 37),
        selectedIndex: selectedPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.person, color: Colors.white),
            icon: Icon(Icons.person_outline, color: Colors.white),
            label: 'Learn',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.engineering, color: Colors.white),
            icon: Icon(Icons.engineering_outlined, color: Colors.white),
            label: 'Relearn',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark, color: Colors.white),
            icon: Icon(Icons.bookmark_border, color: Colors.white),
            label: 'Unlearn',
          ),
        ],
      ),
      body: Column(
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
              margin: EdgeInsets.fromLTRB(10, 60, 10, 10),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final http.Response response = await http.get(
              Uri.parse('https://sheets.googleapis.com/v4/spreadsheets/' +
                  _spreadsheetId),
              headers: await user.authHeaders);

          final Map<String, dynamic> data =
              json.decode(response.body) as Map<String, dynamic>;

          data.forEach((key, value) {
            print('$key: $value');
          });
        },
        tooltip: 'Increment',
        backgroundColor: const Color(0xFF79FF87),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
