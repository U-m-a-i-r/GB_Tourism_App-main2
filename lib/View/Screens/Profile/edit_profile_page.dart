import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/Widgets/default_button.dart';
import 'package:gb_tour/Widgets/rounded_input_field2.dart';

import '../../../Widgets/app_large_text.dart';
import '../Tourist/home_page.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
            alignment: Alignment.center,
            child: AppLargeText(text: "Edit Profile",)),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            //Get.back();
          }, icon: (isDark? Icon(Icons.wb_sunny_outlined) : Icon(Icons.dark_mode_outlined)),color: Colors.black87,)
        ],
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black87,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'lib/assets/person_dp_icon.png',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.indigo,
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        size: 16,
                        color: Colors.white,),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              RoundedInputField2(hintText: 'Full Name', onChanged: (value){}, icon: Icons.person_outlined,),
              RoundedInputField2(hintText: 'Email', onChanged: (value){}, icon: Icons.email_outlined,),
              RoundedInputField2(hintText: 'Phone', onChanged: (value){}, icon: Icons.phone_outlined,),
              RoundedInputField2(hintText: 'Location', onChanged: (value){}, icon: Icons.location_on_outlined,),
              RoundedInputField2(hintText: 'Password', onChanged: (value){}, icon: Icons.fingerprint,),
              DefaultButton(buttonText: 'Edit Profile', press: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
