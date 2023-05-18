import 'package:fabtrack/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64Url, utf8;

import 'auth/log_in.dart';
import '../components/nav.dart';

import '../utils.dart';

class CheckIn extends StatelessWidget {
  /*
  Handles both checking in and out of the Fab Lab
  */
  CheckIn({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount
      user; // not sure if you actually need this, just did it because other pages had it

  late String studentGroup;
  late String activity;
  late String host;
  late String spaceUsed;

  bool signingIn = false;

  @override
  Widget build(BuildContext context) {
    void check_in() async {
      if (!signingIn) {
        signingIn = true;
        
        print("Checking in");

        try {
          final List<String> parts =
              await user.authentication.then((auth) => auth.idToken!.split('.'));
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

            final http.Response signIn = await http.put(
                Uri.parse(
                    'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/Timesheet!A$currentSignedInRow:J$currentSignedInRow?valueInputOption=RAW'),
                headers: await user.authHeaders,
                body: json.encode({
                  "range": "Timesheet!A$currentSignedInRow:J$currentSignedInRow",
                  "majorDimension": "ROWS",
                  "values": [
                    [
                      idMap!["given_name"],
                      idMap["family_name"],
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

            if (signIn.statusCode == 200) {
              print('Signed in');
              isCheckedIn = true;
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return Nav(user: user);
              }));
            } else {
              print(signIn.body);
            }
          } else {
            print(timesheet.body);
          }
        } catch (e) {
          print(e);
        }

        signingIn = false;
      }
    }

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
            child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
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

                // margin: const EdgeInsets.only(bottom: 10),
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Text(
                    user.displayName!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 135,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            fillColor: Color(0xFF80838B),
                            filled: true,
                            border: UnderlineInputBorder(),
                            labelText: 'Student Group',
                          ),
                          onChanged: (value) => studentGroup = value,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            fillColor: Color(0xFF80838B),
                            filled: true,
                            border: UnderlineInputBorder(),
                            labelText: 'Activity',
                          ),
                          onChanged: (value) => activity = value,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: DropdownButtonFormField(
                          value: null,
                          items: [
                            'Ashe Sonntag',
                            'Bobby McAdams',
                            'Cannon Rich',
                            'Clara Sadowski',
                            'Eric Apostal',
                            'Ethan Winebarger',
                            'Nadula Gardiyehewa',
                            'Min Green',
                            'Pratham Madaram'
                          ].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            fillColor: Color(0xFF80838B),
                            filled: true,
                            border: UnderlineInputBorder(),
                            labelText: 'Host',
                          ),
                          onChanged: (value) => host = value.toString(),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: DropdownButtonFormField(
                          value: null,
                          items: [
                            'Classroom Space',
                            'Maker Space',
                            '3D Printers',
                            'Glowforge',
                            'Crafts Area',
                            'Woodshop',
                            'Metalshop'
                          ].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            fillColor: Color(0xFF80838B),
                            filled: true,
                            border: UnderlineInputBorder(),
                            labelText: 'Space Used',
                          ),
                          onChanged: (value) => spaceUsed = value.toString(),
                        )),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 103, 255, 156),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                      onPressed: () {
                        check_in();
                      },
                      child: Container(
                          child: const Text(
                        "Sign in to Fab Lab",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  ),
                ],
              ))
        ])),
      ),
    );
  }
}
