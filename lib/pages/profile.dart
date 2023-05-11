import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../auth/log_in.dart';

class Profile extends StatelessWidget {
  Profile({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/spreadsheets',
  ]);

  @override
  Widget build(BuildContext context) {
    logOut() async {
      _googleSignIn.signOut();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Login();
      }));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          // margin: const EdgeInsets.all(10.0),
          // color: Color(0xFF80838B),
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
        ),
        ElevatedButton.icon(
            onPressed: logOut,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 148, 52, 52),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(12.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Log out'))
      ],
    );
  }
}
