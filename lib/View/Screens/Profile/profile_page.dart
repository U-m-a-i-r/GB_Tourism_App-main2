import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/Widgets/app_large_text.dart';
import 'package:gb_tour/Widgets/app_text.dart';

import '../Login.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final List profileMenuList = [
    // {
    //   "leading": Container(
    //     width: 40,
    //     height: 40,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(100),
    //       color: Colors.indigo.withOpacity(0.1),
    //     ),
    //     child: const Icon(
    //       Icons.settings_outlined,
    //       color: Colors.indigo,
    //     ),
    //   ),
    //   "title": "Settings",
    //   "action_id": 1,
    //   "trailing": Container(
    //     width: 30,
    //     height: 30,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(100),
    //       color: Colors.indigo.withOpacity(0.1),
    //     ),
    //     child: const Icon(
    //       Icons.arrow_forward_ios,
    //       size: 16,
    //       color: Colors.grey,
    //     ),
    //   )
    // },
    // {
    //   "leading": Container(
    //     width: 40,
    //     height: 40,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(100),
    //       color: Colors.indigo.withOpacity(0.1),
    //     ),
    //     child: const Icon(
    //       Icons.help_outline,
    //       color: Colors.indigo,
    //     ),
    //   ),
    //   "title": "Help Center",
    //   "action_id": 2,
    //   "trailing": Container(
    //     width: 30,
    //     height: 30,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(100),
    //       color: Colors.grey.withOpacity(0.1),
    //     ),
    //     child: const Icon(
    //       Icons.arrow_forward_ios,
    //       size: 16,
    //       color: Colors.grey,
    //     ),
    //   )
    // },
    {
      "leading": Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.indigo.withOpacity(0.1),
        ),
        child: const Icon(
          Icons.logout,
          color: Colors.indigo,
        ),
      ),
      "title": "Logout",
      "action_id": 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
            alignment: Alignment.center,
            child: AppLargeText(
              text: "Profile",
            )),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: (isDark
                ? Icon(Icons.wb_sunny_outlined)
                : Icon(Icons.dark_mode_outlined)),
            color: Colors.black87,
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
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
                        Icons.edit,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              AppLargeText(
                text: 'User Name',
                size: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      side: BorderSide.none,
                      shape: StadiumBorder(),
                    ),
                    child: AppLargeText(
                      text: 'Edit Profile',
                      size: 18,
                      color: Colors.white,
                    )),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(
                height: 20,
              ),
              ...profileMenuList.map((sideMenuData) {
                return ListTile(
                  leading: sideMenuData['leading'],
                  title: AppText(
                    text: sideMenuData['title'],
                    size: 16,
                  ),
                  trailing: sideMenuData['trailing'],
                  onTap: () {
                    Navigator.pop(context);
                    if (sideMenuData['action_id'] == 3) {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    }
                    // else if (sideMenuData['action_id'] == 3) {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => const NotificationPage(),
                    //     ),
                    //   );
                    // }
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
