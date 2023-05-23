import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:fabtrack/globals.dart';
import 'package:fabtrack/utils.dart';

import '../components/nav.dart';

class CheckIn extends StatelessWidget {
  CheckIn({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  // Form values
  String studentGroup = "";
  String activity = "";
  String host = "";
  String spaceUsed = "";

  bool checkingIn = false;

  @override
  Widget build(BuildContext context) {
    /// Checks in and navigates to the home page.
    void checkInAndNavigate() async {
      if (!checkingIn) {
        checkingIn = true;

        if (host.isEmpty ||
            studentGroup.isEmpty ||
            spaceUsed.isEmpty ||
            activity.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please fill out all fields.'),
          ));
          checkingIn = false;
          return;
        }

        try {
          checkIn(user, host, studentGroup, spaceUsed, activity)
              .then((checkInResponse) => {
                    isCheckedIn = true,
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return Nav(user: user);
                    }))
                  });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('An error occurred while checking in.'),
          ));
        }

        checkingIn = false;
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
                            labelStyle: TextStyle(color: Color.fromARGB(255, 73, 75, 80)),
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
                            labelStyle: TextStyle(color: Color.fromARGB(255, 73, 75, 80)),
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
                            labelStyle:TextStyle(color: Color.fromARGB(255, 73, 75, 80)),
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
                        color: Color.fromARGB(255, 52, 96, 148),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                      onPressed: () {
                        checkInAndNavigate();
                      },
                      child: const Text(
                        "Check in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ])),
      ),
    );
  }
}
