import 'package:google_sign_in/google_sign_in.dart';
// import 'package:fabtrack/home.dart';
import 'package:fabtrack/erichome.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatelessWidget {
  Login({Key? key, required this.title}) : super(key: key);
  final String title;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/spreadsheets',
  ]);

  @override
  Widget build(BuildContext context) {
    logIn() async {
      await _googleSignIn.signIn().then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(title: 'Home', user: value!),
          ),
        );
      });
    }

    return Scaffold(
      //backgroundColor : Colors.white,
          //border: 
        //const Color.fromRGBO(79, 82, 90, 1),
        body: Center(
          child: Container(
         //padding: EdgeInsets.all(12.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [              
                   Image.asset('lib/images/NCSSMLogo.png', fit:BoxFit.fill),
                   Center(
                    child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("North Carolina",
                              maxLines: 1,
                              softWrap: false,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color:Color.fromARGB(255,90,89,93), ),
                        ),
                        Text("School of Science",
                              maxLines: 1,
                              softWrap: false,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 36.0, fontFamily: 'Montserrat',  fontWeight: FontWeight.bold, color:Color.fromARGB(255,90,89,93),),
                        ),
                        Text("and Mathematics",
                              maxLines: 1,
                              softWrap: false,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color:Color.fromARGB(255,90,89,93),),
                        )
                      ],
                        )
                      )
                    )
              ],), 
            

                const Padding(
                    padding: EdgeInsets.only(bottom: 19.0),
                    child: Text("Welcome to FabTrack!",
                        style: TextStyle(
                            fontSize: 36.0,  color:Color.fromARGB(255,90,89,93), fontFamily: 'Monserrat')
                            )),
                Padding(
                  padding: const EdgeInsets.only(left: 270, right: 270),
                  child: ElevatedButton.icon(
                      onPressed: logIn,
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF80838B),
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.grey,
                        padding: const EdgeInsets.all(12.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          //side: BorderSide(width: 3, color:Color.fromARGB(255,90,89,93)),
                        ),
                      ),
                      icon: const FaIcon(FontAwesomeIcons.google),
                      label: const Text('Login with Google', style: TextStyle(fontFamily: 'Monserrat')),
                              ),
                ),
        ],),),
      ),);
  }
}
