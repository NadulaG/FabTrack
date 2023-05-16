import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth/log_in.dart';

class CheckIn extends StatelessWidget {
  /*
  Handles both checking in and out of the Fab Lab
  */
  const CheckIn({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount
      user; // not sure if you actually need this, just did it because other pages had it

  @override
  Widget build(BuildContext context) {
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
                Text(
                  user.displayName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
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
                            labelText: 'Space Used',
                          ),
                        )),
                  ),
                  Material(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: DropdownButtonFormField(
                        value: null,
                        items: ['Eric', 'Clara', 'Ethan', 'Nadula']
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          fillColor: Color(0xFF80838B),
                          filled: true,
                          border: UnderlineInputBorder(),
                          labelText: 'TA Sponsor',
                        ),
                        onChanged: (value) => print("dropdown selected"),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 103, 255, 156),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                      child: Container(),
                      onPressed: () => print("Submit Button Clicked"),
                    ),
                  ),
                ],
              ))
        ])),
      ),
    );
  }
}
