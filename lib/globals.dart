library globals;

import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
  'email',
  'https://www.googleapis.com/auth/userinfo.profile',
  'https://www.googleapis.com/auth/spreadsheets',
]);

String spreadsheetId = '1JF3wS10ayFZISBne_MuluZb0MkV-fzrJWAcGdgN4_N8';
bool isCheckedIn = false;
int currentSignedInRow = 0;

List globalTools = [];
