import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fabtrack/globals.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  @override
  Widget build(BuildContext context) {
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
        ValueListenableBuilder(
            valueListenable: recentCheckIns,
            builder: (context, value, widget) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height - 220,
                  child: ListView.builder(
                      itemCount: recentCheckIns.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 100,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: const Color(0xFF80838B),
                              border:
                                  Border.all(color: const Color(0xFF80838B)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(children: [
                                        Container(
                                          margin: const EdgeInsets.all(4),
                                          padding: const EdgeInsets.all(4),
                                          height: 45,
                                          width: 165,
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 52, 96, 148),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Center(
                                            child: Text(
                                              recentCheckIns.value[index][7],
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          recentCheckIns.value[index][9],
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          recentCheckIns.value[index][10] +
                                              "-" +
                                              recentCheckIns.value[index][11],
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ])),
                                  const Spacer(),
                                  Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            recentCheckIns.value[index][3] +
                                                " " +
                                                recentCheckIns.value[index][4],
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            recentCheckIns.value[index][6],
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            recentCheckIns.value[index][5],
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          ),
                        );
                      }));
            })
      ],
    );
  }
}
