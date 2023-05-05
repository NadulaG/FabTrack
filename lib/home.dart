import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gsheets/gsheets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'auth/log_in.dart';

class Home extends StatelessWidget {
  final GoogleSignInAccount user;

  Home({Key? key, required this.title, required this.user}) : super(key: key);
  final String title;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/spreadsheets',
  ]);

  final _spreadsheetId = '1JF3wS10ayFZISBne_MuluZb0MkV-fzrJWAcGdgN4_N8';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.photoUrl.toString())),
        Text(user.displayName.toString()),
        Text(user.email),
        TextButton(
            onPressed: () async {
              _googleSignIn.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login(title: 'Login')));
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 52, 96, 148),
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.grey,
              padding: const EdgeInsets.all(12.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
            child: const Icon(Icons.logout)),
        TextButton(
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
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 52, 96, 148),
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.grey,
              padding: const EdgeInsets.all(12.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
            child: const Icon(Icons.info))
      ])),
    );
  }
}
