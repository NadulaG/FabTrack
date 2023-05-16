import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth/log_in.dart';

class CheckIn extends StatelessWidget {
  /*
  Handles both checking in and out of the Fab Lab
  */
  const CheckIn({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount
      user; // not sure if you actually need this, just did it because other pages had it

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl?.toString() ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/680px-Default_pfp.svg.png?20220226140232'),
                radius: 24,
              ),
            ),
            Text(
              user.displayName!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
