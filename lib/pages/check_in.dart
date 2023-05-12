import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth/log_in.dart';

class CheckIn extends StatelessWidget {
  /*
  Handles both checking in and out of the Fab Lab
  */
  const CheckIn({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user; // not sure if you actually need this, just did it because other pages had it

  @override
  Widget build(BuildContext context) {
    return         Container(
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
              child: Text('Eric Apostal', // replace with username
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 24,
                  )),
            ),
          ),
    );
  }
}
