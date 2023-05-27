import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fabtrack/globals.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  void _showUserModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: const Color(0xFF4F525A),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: trainingLevel.value == 0
                      ? Colors.green
                      : trainingLevel.value == 1
                          ? Colors.grey
                          : trainingLevel.value == 2
                              ? Colors.amber
                              : Colors.purple,
                  child: Text(trainingLevel.value.toString()),
                ),
                title: Text(
                    trainingLevel.value == 0
                        ? "Green: Level 0"
                        : trainingLevel.value == 1
                            ? "Silver: Level 1"
                            : trainingLevel.value == 2
                                ? "Gold: Level 2"
                                : "Purple: Level 3",
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text(
                    trainingLevel.value == 0
                        ? "Cleared TA/Instructor"
                        : trainingLevel.value == 1
                            ? "Cleared TA/Instructor"
                            : trainingLevel.value == 2
                                ? "Cleared TA/Instructor ONLY"
                                : "Instructor ONLY",
                    style: const TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _showUserModal(context);
          },
          child: Container(
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
                      child: ValueListenableBuilder(
                          valueListenable: trainingLevel,
                          builder: (context, value, widget) {
                            return Badge(
                              alignment: AlignmentDirectional.topStart,
                              backgroundColor: trainingLevel.value == 0
                                  ? Colors.green
                                  : trainingLevel.value == 1
                                      ? Colors.grey
                                      : trainingLevel.value == 2
                                          ? Colors.amber
                                          : Colors.purple,
                              label: Text(trainingLevel.value.toString()),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.photoUrl
                                        ?.toString() ??
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/680px-Default_pfp.svg.png?20220226140232'),
                                radius: 24,
                              ),
                            );
                          })),
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
        ),
        ValueListenableBuilder(
            valueListenable: loadedRecentCheckIns,
            builder: (context, value, widget) {
              return !loadedRecentCheckIns.value
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [CircularProgressIndicator()],
                      ))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height - 220,
                      child: ListView.builder(
                          itemCount: recentCheckIns.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 100,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF80838B),
                                  border: Border.all(
                                      color: const Color(0xFF80838B)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Center(
                                                child: Text(
                                                  recentCheckIns[index][7],
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              recentCheckIns[index][9],
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              recentCheckIns[index][10] +
                                                  "-" +
                                                  recentCheckIns[index][11],
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ])),
                                      const Spacer(),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                recentCheckIns[index][3] +
                                                    " " +
                                                    recentCheckIns[index][4],
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                recentCheckIns[index][6],
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                recentCheckIns[index][5],
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
