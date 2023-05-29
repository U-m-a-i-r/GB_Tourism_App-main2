import 'package:flutter/material.dart';
import 'app_large_text.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;
  final dynamic press;

  const DefaultButton({Key? key, required this.buttonText, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
          backgroundColor: Colors.indigo,
        ),
        onPressed: press,
        child: AppLargeText(text: buttonText, color: Colors.white, size: 18),
      ),
    );
  }
}