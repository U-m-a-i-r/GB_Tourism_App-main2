import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/Login.dart';
import 'package:gb_tour/View/Screens/onboardingContent.dart';
import 'package:gb_tour/Widgets/app_text.dart';
import 'package:gb_tour/Widgets/default_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Tourist/home_page.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(top: 30, right: 30),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  },
                    child: AppText(text: 'Skip'))),
            Expanded(
              child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 40, left: 35, right: 35),
                      child: Column(
                        children: [
                          Image.asset(
                            contents[index].image,
                            height: 300,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            contents[index].title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            contents[index].description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(9),
              child: DefaultButton(
                buttonText:
                    currentIndex == contents.length - 1 ? "Continue" : "Next",
                press: () {
                  if (currentIndex == contents.length - 1) {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => LoginScreen()));
                  }
                  _controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.3),
      ),
    );
  }
}
