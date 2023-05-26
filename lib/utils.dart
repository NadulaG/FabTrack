import 'dart:convert' show json, base64Url, utf8;
import 'package:http/http.dart' as http;

import 'package:google_sign_in/google_sign_in.dart';

import 'package:fabtrack/globals.dart';

/// Parses authentication ID token from OAuth and obtain relevant information.
Map<String, dynamic>? parseJwt(String token) {
  if (token.isEmpty) return null;
  final List<String> parts = token.split('.');
  if (parts.length != 3) {
    return null;
  }
  final String payload = parts[1];
  final String normalized = base64Url.normalize(payload);
  final String resp = utf8.decode(base64Url.decode(normalized));
  final payloadMap = json.decode(resp);
  if (payloadMap is! Map<String, dynamic>) {
    return null;
  }
  return payloadMap;
}

/// Checks in a user to the spreadsheet.
Future<http.Response> checkIn(GoogleSignInAccount user, String host,
    String studentGroup, String spaceUsed, String activity) async {
  Map<String, dynamic>? idMap =
      parseJwt(await user.authentication.then((auth) => auth.idToken!));

  final http.Response timesheet = await http.get(
    Uri.parse(
        'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/Timesheet!A1:Z1000'),
    headers: await user.authHeaders,
  );

  if (timesheet.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(timesheet.body);
    currentSignedInRow = data.values.elementAt(2).length + 1;

    final http.Response checkInResponse = await http.put(
        Uri.parse(
            'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/Timesheet!A$currentSignedInRow:K$currentSignedInRow?valueInputOption=RAW'),
        headers: await user.authHeaders,
        body: json.encode({
          "range": "Timesheet!A$currentSignedInRow:K$currentSignedInRow",
          "majorDimension": "ROWS",
          "values": [
            [
              idMap!["given_name"],
              idMap["family_name"],
              user.email,
              host.split(' ')[0],
              host.split(' ')[1],
              studentGroup,
              spaceUsed,
              activity,
              "N/A",
              "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
              "${DateTime.now().hour % 12}:${DateTime.now().minute} ${DateTime.now().hour > 12 ? 'PM' : 'AM'}"
            ]
          ]
        }));
    if (checkInResponse.statusCode == 200) {
      return checkInResponse;
    } else {
      throw Exception('Failed to load spreadsheet');
    }
  } else {
    throw Exception('Failed to load spreadsheet');
  }
}

/// Checks out a user from the spreadsheet.
Future<http.Response> checkOut(user) async {
  final http.Response checkOutResponse = await http.put(
      Uri.parse(
          'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/Timesheet!L$currentSignedInRow:L$currentSignedInRow?valueInputOption=RAW'),
      headers: await user.authHeaders,
      body: json.encode({
        "range": "Timesheet!L$currentSignedInRow:L$currentSignedInRow",
        "majorDimension": "ROWS",
        "values": [
          [
            "${DateTime.now().hour % 12}:${DateTime.now().minute} ${DateTime.now().hour > 12 ? 'PM' : 'AM'}"
          ]
        ]
      }));

  if (checkOutResponse.statusCode == 200) {
    return checkOutResponse;
  } else {
    throw Exception('Failed to load spreadsheet');
  }
}

/// Checks out a tool from the spreadsheet.
Future<http.Response> toolCheckOut(GoogleSignInAccount user) async {
  final http.Response toolCheckOutResponse = await http.put(
      Uri.parse(
          'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/Timesheet!I$currentSignedInRow:I$currentSignedInRow?valueInputOption=RAW'),
      headers: await user.authHeaders,
      body: json.encode({
        "range": "Timesheet!I$currentSignedInRow:I$currentSignedInRow",
        "majorDimension": "ROWS",
        "values": [
          [globalTools.toString()]
        ]
      }));

  if (toolCheckOutResponse.statusCode == 200) {
    return toolCheckOutResponse;
  } else {
    throw Exception('Failed to load spreadsheet');
  }
}

/// Returns the timesheet spreadsheet.
Future<Map<String, dynamic>> getTimesheet(user) async {
  final http.Response timesheet = await http.get(
    Uri.parse(
        'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/Timesheet!A1:Z1000'),
    headers: await user.authHeaders,
  );

  if (timesheet.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(timesheet.body);
    return data;
  } else {
    throw Exception('Failed to load spreadsheet');
  }
}

/// Returns a user's training level.
Future<int> getTraining(user) async {
  final http.Response training = await http.get(
    Uri.parse(
        'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/Training!A1:Z1000'),
    headers: await user.authHeaders,
  );

  if (training.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(training.body);
    for (int i = 0; i < data.values.elementAt(2).length; i++) {
      if (data.values.elementAt(2)[i][1] == user.email) {
        return int.parse(data.values.elementAt(2)[i][3]);
      }
    }
    return 0;
  } else {
    throw Exception('Failed to load spreadsheet');
  }
}
