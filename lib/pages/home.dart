import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:fabtrack/globals.dart';

import '../pages/check_in.dart';
import '../components/tool_card.dart';

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

class _HomeState extends State<Home> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    /// Navigates to check in page if Fab Lab NFC tag is scanned.
    void nfcTask(context) async {
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          if (listEquals(tag.data["nfca"]["identifier"],
              [4, 148, 88, 162, 136, 50, 128])) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CheckIn(user: widget.user);
            }));
          }
        },
      );
    }

    nfcTask(context);

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
              child: Text(
                  isCheckedIn ? 'Status: Checked In' : 'Status: Checked Out',
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
        ActivityCard(globalTools)
      ],
    );
  }
}
