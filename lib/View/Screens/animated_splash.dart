import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/welcome.dart';

import 'Tourist/home_page.dart';

class AnimatedSplash extends StatefulWidget {
  const AnimatedSplash({Key? key}) : super(key: key);

  @override
  State<AnimatedSplash> createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash> {
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      FirebaseAuth.instance.currentUser == null
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Welcome()))
          : Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "GB Tourism",
            //     style: TextStyle(
            //     fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // ),
            Container(
              height: 130,
              width: 130,
              color: Colors.indigo,
              child: Image.asset('lib/assets/Gilgit_Logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
