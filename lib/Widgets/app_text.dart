import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class AppText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  AppText(
      {Key? key,
        required this.text,
        this.color = Colors.black87,
        this.size = 18,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
          color: color,
          fontSize: size,
      ),
    );
  }
}
