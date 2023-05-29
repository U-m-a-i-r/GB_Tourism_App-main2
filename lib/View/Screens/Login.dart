import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/reset_pass.dart';
import 'package:gb_tour/View/Screens/sign_up.dart';
import 'package:gb_tour/Widgets/app_large_text.dart';
import 'package:gb_tour/Widgets/app_text.dart';
import 'package:get/get.dart';

import '../../Widgets/default_button.dart';
import '../../Widgets/rounded_input_field.dart';
import '../../Widgets/rounded_pass_field.dart';
import '../../utils/progress_dialog_utils.dart';
import 'Tourist/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  login() async {
    if (_email.text.isEmpty || _pass.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: "Email & Password in required!",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    } else {
      try {
        ProgressDialogUtils.showProgressDialog();
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _pass.text,
        );
        ProgressDialogUtils.hideProgressDialog();
        // User successfully signed in
        User? user = userCredential.user;
        if (user != null) {
          var userDoc = await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .get();
          if (userDoc.exists) {
            // if (userDoc['role'] == 1) {
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => const HSPHomePage()));
            // } else if (userDoc['role'] == 2) {
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => const HSPHomePage()));
            // } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
            // }
          }
        }

        //  Continue with further logic
      } catch (e) {
        if (e is FirebaseAuthException) {
          Get.showSnackbar(GetSnackBar(
            message: e.message,
            duration: Duration(seconds: 4),
            backgroundColor: Colors.red,
          ));
        } else {
          print('Error: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: 250,
                  color: Colors.indigo,
                )),
            Positioned(
              top: 200,
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: AppLargeText(text: 'Login')),
                      const SizedBox(height: 20),
                      RoundedInputField(
                        hintText: 'Your Email',
                        onChanged: (value) {},
                        controller: _email,
                      ),
                      RoundedPasswordField(
                        onChanged: (value) {},
                        controller: _pass,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResetPassScreen()));
                            },
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: AppLargeText(
                                    text: 'Forgot Password?',
                                    size: 18,
                                  ),
                                ))),
                      ),
                      const SizedBox(height: 8),
                      DefaultButton(
                        buttonText: 'Login',
                        press: () {
                          login();
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: "Don't have an Account? ",
                            size: 16,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupScreen()));
                              },
                              child: AppLargeText(
                                text: "Sign Up",
                                color: Colors.indigo,
                                size: 16,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
