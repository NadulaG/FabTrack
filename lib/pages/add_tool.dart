import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:fabtrack/globals.dart';
import 'package:fabtrack/utils.dart';

import 'package:fabtrack/components/nav.dart';

class AddTool extends StatelessWidget {
  AddTool({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  String textContent = "";

  /// Adds a tool and navigates to the home page.
  void addTool(context) async {
    globalTools.add({
      "name": textContent,
      "time":
          "${DateTime.now().hour % 12}:${DateTime.now().minute} ${DateTime.now().hour > 12 ? 'PM' : 'AM'}"
    });

    try {
      toolCheckOut(user).then((checkOutResponse) => {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Nav(user: user);
            }))
          });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred while checking out tool.'),
      ));
    }
  }

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
                          onChanged: (text) {
                            textContent = text;
                          },
                          decoration: const InputDecoration(
                            fillColor: Color(0xFF80838B),
                            filled: true,
                            border: UnderlineInputBorder(),
                            labelText: 'Tool Name',
                          ),
                        )),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 52, 96, 148),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                      child: const Text(
                        "Check out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => {addTool(context)},
                    ),
                  ),
                ],
              ))
        ])),
      ),
    );
  }
}
