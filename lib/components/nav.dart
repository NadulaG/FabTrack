import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../pages/home.dart';
import '../pages/profile.dart';
import '../pages/check_in.dart';
import '../components/tool_cards.dart';

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
          FloatingActionButton(
            backgroundColor: const Color.fromRGBO(52, 96, 148, 1),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CheckIn(user: widget.user);
              }));
            },
            heroTag: null,
            child: const Icon(Icons.login),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: const Color.fromRGBO(52, 96, 148, 1),
            onPressed: () {
              
              print("do thing to recall constructor with all new cards");
            },
            heroTag: null,
            child: const Icon(Icons.add),
          )
        ]));
  }
}
