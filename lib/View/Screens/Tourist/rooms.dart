import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/Tourist/room_detail_page.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../../../Widgets/default_button.dart';

class Rooms extends StatefulWidget {
  final dynamic hotelId;
  const Rooms({Key? key, required this.hotelId}) : super(key: key);

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
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
              margin: EdgeInsets.only(left: 105),
              child: AppLargeText(
                text: 'Rooms',
                size: 20,
              ),
            ),
            Spacer(),
            GestureDetector(
                onTap: () {
                  showRoomsFilterDialog(context);
                },
                child: Icon(Icons.filter_list)),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Rooms')
              .where('hotelId', isEqualTo: widget.hotelId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Text('No data available');
            }
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RoomDetailPage(
                                    roomDetails: snapshot.data!.docs[index],
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      padding: const EdgeInsets.all(12),
                      height: 180,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(
                              snapshot.data!.docs[index]['images'][0]),
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
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                                size: 25,
                              ),
                              onTap: () {
                                toggleFavorite();
                              },
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: AppText(
                              text: snapshot.data!.docs[index]['name'],
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
                });
          }),
    );
  }

  showRoomsFilterDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: AppLargeText(
        text: "Find your perfect room",
        size: 22,
      ),
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Rooms(
                            hotelId: widget.hotelId,
                          )));
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
