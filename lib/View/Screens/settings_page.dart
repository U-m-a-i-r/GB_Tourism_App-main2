import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/Widgets/app_text.dart';

import '../../Widgets/app_large_text.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switch = false;
  ThemeData _dark = ThemeData(brightness: Brightness.dark);
  ThemeData _light = ThemeData(brightness: Brightness.light);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _switch ? _dark : _light,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 110),
                  child: AppLargeText(
                    text: 'Settings',
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8, left: 25),
          child: Row(
            children: [
              AppText(text: "Dark Theme"),
              Spacer(),
              Switch(
                  activeColor: Colors.indigo,
                  value: _switch,
                  onChanged: (_newValue) {
                    setState(() {
                      _switch = _newValue;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
