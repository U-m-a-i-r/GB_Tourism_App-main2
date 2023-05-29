import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/Tourist/csp_detail_page.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../../../Widgets/default_button.dart';
import '../drawer.dart';

class Cars extends StatefulWidget {
  const Cars({Key? key}) : super(key: key);

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 110),
              child: AppLargeText(
                text: 'Cars',
                size: 20,
              ),
            ),
            const Spacer(),
            GestureDetector(
                onTap: (){
                  showCarsFilterDialog(context);
                },
                child: Icon(Icons.filter_list)),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      drawer: const DrawerScreen(),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 8,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const CSPDetailPage()));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.all(12),
                height: 180,
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
                    Container(
                      alignment: Alignment.topRight,
                      child: GestureDetector(

                        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 25,
                        ),
                        onTap: (){
                          toggleFavorite();
                        },
                      ),
                    ),
                    const Spacer(),
                    Container(
                      child: AppText(
                        text: 'Car Name',
                        color: Colors.white,
                        size: 20,
                      ),
                      alignment: Alignment.bottomLeft,
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
  showCarsFilterDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: AppLargeText(text: "Find your perfect car", size: 22,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          DefaultButton(
            buttonText: "Filter",
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Cars()));
            },
          ),
        ],
      ),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
