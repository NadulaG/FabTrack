import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../pages/home.dart';
import '../pages/profile.dart';
import '../pages/check_in.dart';
import '../pages/add_part.dart';
import '../components/tool_cards.dart';

import '../globals.dart';

class Nav extends StatefulWidget {
  final GoogleSignInAccount user;

  const Nav({Key? key, required this.user}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  void onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  late List<Widget> _children;

  @override
  void initState() {
    _children = [
      Home(user: widget.user),
      Profile(user: widget.user),
    ];
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return Nav(user: widget.user);
        }));
      },
    );

    Widget continueButton = TextButton(
      child: Text("Check out"),
      onPressed: () {
        isCheckedIn = false;
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return Nav(user: widget.user);
        }));
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Would you like to check out of the Fab Lab?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(79, 82, 90, 1),
        body: _children.elementAt(_selectedIndex),
        bottomNavigationBar: NavigationBar(
          backgroundColor: const Color(0xFF80838B),
          selectedIndex: _selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          !isCheckedIn
              ? FloatingActionButton(
                  backgroundColor: const Color.fromRGBO(52, 96, 148, 1),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return CheckIn(user: widget.user);
                    }));
                  },
                  heroTag: null,
                  child: const Icon(Icons.login),
                )
              : SizedBox(),
          const SizedBox(
            height: 10,
          ),
          isCheckedIn
              ? FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 148, 52, 52),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  heroTag: null,
                  child: const Icon(Icons.login),
                )
              : SizedBox(),
          const SizedBox(
            height: 10,
          ),
          isCheckedIn
              ? FloatingActionButton(
                  backgroundColor: const Color.fromRGBO(52, 96, 148, 1),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddPart(user: widget.user);
                    }));
                  },
                  heroTag: null,
                  child: const Icon(Icons.add),
                )
              : SizedBox(),
        ]));
  }
}
