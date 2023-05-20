import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:fabtrack/globals.dart';

import 'auth/log_in.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  @override
  Widget build(BuildContext context) {
    /// Logs out and navigates to the login page.
    logOut() async {
      googleSignIn.signOut().then((_) => {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const Login();
            }))
          });
    }

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
