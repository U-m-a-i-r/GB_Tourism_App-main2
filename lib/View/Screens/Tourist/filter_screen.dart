import 'package:flutter/material.dart';
import 'package:gb_tour/Widgets/default_button.dart';

import '../../../Widgets/app_large_text.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List dropDownPlaceList = [
    {"title": "Hunza", "value": "1"},
    {"title": "Skardu", "value": "2"},
    {"title": "Shigar", "value": "3"},
    {"title": "Tolti", "value": "4"},
  ];
  List dropDownBudgetList = [
    {"title": "10,000 to 20,000 Rs", "value": "1"},
    {"title": "20,000 to 40,000 Rs", "value": "2"},
    {"title": "40,000 to 60,000 Rs", "value": "3"},
    {"title": "60,000 to onwards", "value": "4"},
  ];

  String defaultValue = "";
  String secondDropDown = "";
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
              left: 10,
              top: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              top: 200,
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: const EdgeInsets.only( top: 50, right: 25, left: 25),
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
                      Center(child: AppLargeText(text: 'Find your perfect place')),
                      const SizedBox(height: 75),
                      Align(
                          alignment: Alignment.topLeft,
                          child: AppLargeText(text: "Place", size: 20, )),
                      SizedBox(height: 8,),
                      InputDecorator(
                        decoration: InputDecoration(
                          border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              isDense: true,
                              value: defaultValue,
                              isExpanded: true,
                              menuMaxHeight: 350,
                              items: [
                                const DropdownMenuItem(
                                    child: Text(
                                      "Select Place",
                                    ),
                                    value: ""),
                                ...dropDownPlaceList.map<DropdownMenuItem<String>>((data) {
                                  return DropdownMenuItem(
                                      child: Text(data['title']), value: data['value']);
                                }).toList(),
                              ],
                              onChanged: (value) {
                                print("selected Value $value");
                                setState(() {
                                  defaultValue = value!;
                                });
                              }),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Align(
                          alignment: Alignment.topLeft,
                          child: AppLargeText(text: "Budget", size: 20, )),
                      SizedBox(height: 8,),
                      InputDecorator(
                        decoration: InputDecoration(
                          border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              isDense: true,
                              value: defaultValue,
                              isExpanded: true,
                              menuMaxHeight: 350,
                              items: [
                                const DropdownMenuItem(
                                    child: Text(
                                      "Select Budget",
                                    ),
                                    value: ""),
                                ...dropDownBudgetList.map<DropdownMenuItem<String>>((data) {
                                  return DropdownMenuItem(
                                      child: Text(data['title']), value: data['value']);
                                }).toList(),
                              ],
                              onChanged: (value) {
                                print("selected Value $value");
                                setState(() {
                                  defaultValue = value!;
                                });
                              }),
                        ),
                      ),
                      SizedBox(height: 10,),
                      DefaultButton(buttonText: "Filter",)
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

