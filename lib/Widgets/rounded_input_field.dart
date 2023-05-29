
import 'package:flutter/material.dart';
import 'package:gb_tour/Widgets/text_field_container.dart';


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const RoundedInputField(
      {Key? key, required this.hintText, this.icon = Icons.person , required this.onChanged, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Colors.indigo,
            ),
            hintText: hintText,
            border: InputBorder.none
        ),
      ),
    );
  }
}