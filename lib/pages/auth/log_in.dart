import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fabtrack/globals.dart';

import '../../components/nav.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Logs in with Google and navigates to the home page.
    void logIn() async {
      try {
        await googleSignIn.signIn().then((user) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Nav(user: user!),
            ),
          );
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("An error occurred while logging in.")));
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(79, 82, 90, 1),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text("FabTrack",
                      style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              ElevatedButton.icon(
                  onPressed: logIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 52, 96, 148),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  icon: const FaIcon(FontAwesomeIcons.google),
                  label: const Text('Log in with Google'))
            ]),
      )),
    );
  }
}
