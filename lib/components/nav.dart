import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../pages/home.dart';
import '../pages/profile.dart';

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
      const Text('Search'),
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
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromRGBO(52, 96, 148, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
