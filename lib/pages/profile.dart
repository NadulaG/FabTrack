import 'package:fabtrack/utils.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fabtrack/globals.dart';

import 'auth/log_in.dart';

class Profile extends StatelessWidget {
  Profile({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  List cardsList = [];

  @override
  Widget build(BuildContext context) {
    getTimesheet(user).then((timesheet) => {
          cardsList.clear(),
          timesheet.values.elementAt(2).forEach((element) {
            if (element[2] == user.email) {
              cardsList.add(element);
            }
          }),
        });

    print(cardsList);

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
        SizedBox(
            height: MediaQuery.of(context).size.height - 220,
            child: ListView.builder(
                itemCount: cardsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xFF80838B),
                        border: Border.all(color: const Color(0xFF80838B)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(4),
                                height: 45,
                                width: 120,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 52, 96, 148),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Center(
                                  child: Text(
                                    cardsList[index][7],
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                cardsList[index][9] +
                                    " " +
                                    cardsList[index][10],
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                })),
      ],
    );
  }
}
