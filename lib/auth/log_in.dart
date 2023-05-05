import 'package:google_sign_in/google_sign_in.dart';
// import 'package:fabtrack/home.dart';
import 'package:fabtrack/erichome.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({Key? key, required this.title}) : super(key: key);
  final String title;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/spreadsheets',
  ]);

  @override
  Widget build(BuildContext context) {
    logIn() async {
      await _googleSignIn.signIn().then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(title: 'Home', user: value!),
          ),
        );
      });
    }

    return Scaffold(
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
                          fontSize: 36.0, fontWeight: FontWeight.bold))),
              TextButton(
                  onPressed: logIn,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 52, 96, 148),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.grey,
                    padding: const EdgeInsets.all(12.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  child: const Icon(Icons.login))
            ]),
      )),
    );
  }
}
