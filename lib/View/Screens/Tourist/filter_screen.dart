import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/Widgets/default_button.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../CSP/cars.dart';
import '../HSP/hotels.dart';
import 'csp_detail_page.dart';
import 'hotel_detail_page.dart';

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

  void toggleFavoriteHotels(docId, bool status) {
    FirebaseFirestore.instance
        .collection('Hotels')
        .doc(docId)
        .update({"isFavorite": status ? false : true});
  }

  void toggleFavoriteCar(docId, bool status) {
    FirebaseFirestore.instance
        .collection('Cars')
        .doc(docId)
        .update({"isFavorite": status ? false : true});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(color: Colors.blue),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child:
            // Positioned(
            //     left: 0,
            //     right: 0,
            //     child: Container(
            //       height: 250,
            //       color: Colors.indigo,
            //     )),
            // Positioned(
            //   left: 10,
            //   top: 10,
            //   child: IconButton(
            //     icon: Icon(Icons.arrow_back),
            //     color: Colors.white,
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
            SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: const EdgeInsets.only(top: 50, right: 25, left: 25),
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
                    child: AppLargeText(
                      text: "Place",
                      size: 20,
                    )),
                SizedBox(
                  height: 8,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
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
                          ...dropDownPlaceList
                              .map<DropdownMenuItem<String>>((data) {
                            return DropdownMenuItem(
                                child: Text(data['title']),
                                value: data['value']);
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
                    child: AppLargeText(
                      text: "Budget",
                      size: 20,
                    )),
                SizedBox(
                  height: 8,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
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
                          ...dropDownBudgetList
                              .map<DropdownMenuItem<String>>((data) {
                            return DropdownMenuItem(
                                child: Text(data['title']),
                                value: data['value']);
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
                SizedBox(
                  height: 10,
                ),
                DefaultButton(
                  buttonText: "Filter",
                  press: () {
                    setState(() {});
                  },
                ),
                //show data

                Container(
                  margin: EdgeInsets.only(left: 24, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(text: 'Hotels'),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Hotels()));
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 180,
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(left: 20),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Hotels')
                            .where('place', isEqualTo: defaultValue)
                            //    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.data == null ||
                              snapshot.data!.docs.isEmpty) {
                            return Text('No hotel available');
                          }
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        padding: const EdgeInsets.all(12),
                                        height: 160,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot.data!
                                                .docs[index]['images'][0]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                child: Icon(
                                                  snapshot.data!.docs[index]
                                                          ['isFavorite']
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: Colors.red,
                                                  size: 25,
                                                ),
                                                onTap: () {
                                                  toggleFavoriteHotels(
                                                      snapshot
                                                          .data!.docs[index].id,
                                                      snapshot.data!.docs[index]
                                                          ['isFavorite']);
                                                },
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              child: AppText(
                                                text: snapshot.data!.docs[index]
                                                    ['name'],
                                                color: Colors.white,
                                              ),
                                              alignment: Alignment.bottomLeft,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HotelDetailPage(
                                                      hotelDetails: snapshot
                                                          .data!.docs[index],
                                                    )));
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              });
                        })),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 24, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(text: 'Cars'),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Cars()));
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 180,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(left: 20),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Cars')
                          .where('place', isEqualTo: defaultValue)
                          //    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          return Text('No cars available');
                        }
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.all(12),
                                      height: 160,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]['images'][0]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              child: Icon(
                                                snapshot.data!.docs[index]
                                                        ['isFavorite']
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                              onTap: () {
                                                toggleFavoriteCar(
                                                    snapshot
                                                        .data!.docs[index].id,
                                                    snapshot.data!.docs[index]
                                                        ['isFavorite']);
                                              },
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            child: AppText(
                                              text: snapshot.data!.docs[index]
                                                  ['name'],
                                              color: Colors.white,
                                            ),
                                            alignment: Alignment.bottomLeft,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CSPDetailPage(
                                                    carDetails: snapshot
                                                        .data!.docs[index],
                                                  )));
                                    },
                                  ),
                                ],
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
