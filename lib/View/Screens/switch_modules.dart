import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/Widgets/default_button.dart';

import 'HSP/hsp_home_page.dart';
import 'Tourist/home_page.dart';
import 'CSP/csp_home_page.dart';

class SwitchModules extends StatelessWidget {
  const SwitchModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultButton(buttonText: "Switch to Tourist Module", press: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
            },),
            DefaultButton(buttonText: "Switch to HSP Module", press: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HSPHomePage()));
            },),
            DefaultButton(buttonText: "Switch to CSP Module", press: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CSPHomePage()));
            },),
          ],
        ),
      ),
    );
  }
}
