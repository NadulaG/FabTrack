import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:fabtrack/globals.dart';
import 'package:fabtrack/utils.dart';

import '../pages/home.dart';
import '../pages/auth/log_in.dart';
import '../pages/profile.dart';
import '../pages/check_in.dart';
import '../pages/add_tool.dart';

class Nav extends StatefulWidget {
  final GoogleSignInAccount user;

  const Nav({Key? key, required this.user}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  late List<Widget> _children;
  void onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _children = [
      Home(user: widget.user),
      Profile(user: widget.user),
    ];
  }

  /// Shows an alert dialog for checking out.
  checkOutModal(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    /// Checks out and navigates to the home page.
    void checkOutAndNavigate() {
      try {
        checkOut(widget.user).then((checkOutResponse) => {
              isCheckedIn = false,
              currentSignedInRow = 0,
              globalTools = [],
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Nav(user: widget.user);
              }))
            });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('An error occurred while checking out.'),
        ));
      }
    }

    Widget continueButton = TextButton(
      child: const Text("Check out"),
      onPressed: () async {
        checkOutAndNavigate();
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Check Out"),
      content: const Text("Are you sure you would like to check out?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Logs out and navigates to the login page.
    void logOut() async {
      googleSignIn.signOut().then((_) => {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return Login();
            }))
          });
    }

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
          !isCheckedIn && _children.elementAt(_selectedIndex) is Home
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
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          isCheckedIn && _children.elementAt(_selectedIndex) is Home
              ? FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 148, 52, 52),
                  onPressed: () {
                    checkOutModal(context);
                  },
                  heroTag: null,
                  child: const Icon(Icons.login),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          isCheckedIn && _children.elementAt(_selectedIndex) is Home
              ? FloatingActionButton(
                  backgroundColor: const Color.fromRGBO(52, 96, 148, 1),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddTool(user: widget.user);
                    }));
                  },
                  heroTag: null,
                  child: const Icon(Icons.add),
                )
              : const SizedBox(),
          _children.elementAt(_selectedIndex) is Profile
              ? FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 148, 52, 52),
                  onPressed: () {
                    logOut();
                  },
                  heroTag: null,
                  child: const Icon(Icons.logout),
                )
              : const SizedBox()
        ]));
  }
}
