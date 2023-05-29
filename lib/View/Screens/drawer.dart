import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/Login.dart';
import 'package:gb_tour/View/Screens/Profile/profile_page.dart';
import 'package:gb_tour/View/Screens/switch_modules.dart';
import 'package:gb_tour/Widgets/app_large_text.dart';

import '../../Widgets/app_text.dart';
import 'Tourist/fav_items_page.dart';
import 'Tourist/home_page.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isFavorite = false;
  final List drawerMenuListname = [
    {
      "leading": Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.indigo.withOpacity(0.1),
        ),
        child: const Icon(
          Icons.home_outlined,
          color: Colors.indigo,
        ),
      ),
      "title": "Home",
      "action_id": 1,
    },
    {
      "leading": Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.indigo.withOpacity(0.1),
        ),
        child: const Icon(
          Icons.switch_account,
          color: Colors.indigo,
        ),
      ),
      "title": "Switch",
      "action_id": 2,
    },
    {
      "leading": Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.indigo.withOpacity(0.1),
        ),
        child: const Icon(
          Icons.favorite_border,
          color: Colors.indigo,
        ),
      ),
      "title": "Favorites",
      "action_id": 3,
    },
    {
      "leading": Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.indigo.withOpacity(0.1),
        ),
        child: const Icon(
          Icons.logout_outlined,
          color: Colors.indigo,
        ),
      ),
      "title": "Logout",
      "action_id": 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 280,
        child: Drawer(
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: Container(
                  color: Colors.indigo,
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 36,
                        child: Image.asset(
                          'lib/assets/person_dp_icon.png',
                        ),
                      ),
                      SizedBox(height: 10),
                      AppLargeText(
                        text:
                            FirebaseAuth.instance.currentUser!.email.toString(),
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ...drawerMenuListname.map((sideMenuData) {
                return ListTile(
                  leading: sideMenuData['leading'],
                  title: AppText(
                    text: sideMenuData['title'],
                    size: 16,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    if (sideMenuData['action_id'] == 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } else if (sideMenuData['action_id'] == 2) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SwitchModules(),
                        ),
                      );
                    } else if (sideMenuData['action_id'] == 3) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FavItemsPage(),
                        ),
                      );
                    } else if (sideMenuData['action_id'] == 4) {
                      try {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        print(e.toString());
                      }
                    }
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
