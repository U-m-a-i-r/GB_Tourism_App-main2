import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/CSP/csp_service_form.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../../../Widgets/default_button.dart';
import '../Profile/profile_page.dart';
import '../drawer.dart';

class CSPHomePage extends StatefulWidget {
  const CSPHomePage({Key? key}) : super(key: key);

  @override
  State<CSPHomePage> createState() => _CSPHomePageState();
}

class _CSPHomePageState extends State<CSPHomePage> {
  Color _buttonColor = Colors.red;
  String _buttonText = 'Booked';

  void _changeButtonState() {
    setState(() {
      if (_buttonColor == Colors.grey) {
        _buttonColor = Colors.red;
        _buttonText = 'Booked';
      } else {
        _buttonColor = Colors.grey;
        _buttonText = 'Unbooked';
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
            margin: EdgeInsets.only(left: 30),
            child: Row(
              children: [
                AppLargeText(
                  text: 'Welcome to Dashboard',
                  size: 20,
                ),
                Spacer(),
                CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                        },
                        child: Icon(Icons.person_rounded, color: Colors.black87)))
              ],
            )),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      drawer: DrawerScreen(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: AppLargeText(text: "Active Services"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 85),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: const EdgeInsets.all(10),
                    height: 220,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("lib/assets/WelcomeImage.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PopupMenuButton(
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15),
                              child: AppText(
                                text: "Update",
                              ),
                            ),
                            PopupMenuItem(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15),
                              child: AppText(
                                text: "Delete",
                              ),
                              onTap: () {},
                            ),
                          ],
                          child: Container(
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 25,
                            ),
                            alignment: Alignment.topRight,
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: AppText(
                                text: 'Car Name',
                                color: Colors.white,
                                size: 20,
                              ),
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          width: size.width * 0.9,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: _buttonColor,
                            ),
                            onPressed: _changeButtonState,
                            child: AppLargeText(
                                text: _buttonText,
                                color: Colors.white,
                                size: 18),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Positioned(
              bottom: 0,
              left: 20,
              child: DefaultButton(
                  buttonText: "Create a Service",
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CSPServiceForm()));
                  })),
        ],
      ),
    );
  }
}
