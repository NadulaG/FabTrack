library globals;

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
  'email',
  'https://www.googleapis.com/auth/userinfo.profile',
  'https://www.googleapis.com/auth/spreadsheets',
]);

ValueNotifier<bool> loadedRecentCheckIns = ValueNotifier<bool>(false);
List recentCheckIns = [];

String spreadsheetId = '1JF3wS10ayFZISBne_MuluZb0MkV-fzrJWAcGdgN4_N8';
bool isCheckedIn = false;
int currentSignedInRow = 0;

List globalTools = [];
