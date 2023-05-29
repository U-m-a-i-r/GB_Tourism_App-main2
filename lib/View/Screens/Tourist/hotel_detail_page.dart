import 'package:bulleted_list/bulleted_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/Tourist/room_detail_page.dart';
import 'package:gb_tour/View/Screens/Tourist/rooms.dart';
import 'package:gb_tour/Widgets/app_large_text.dart';

import '../../../Widgets/app_text.dart';
import '../onboarding_hotel_images.dart';

class HotelDetailPage extends StatefulWidget {
  final dynamic hotelDetails;
  const HotelDetailPage({Key? key, required this.hotelDetails})
      : super(key: key);

  @override
  State<HotelDetailPage> createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  late PageController _controller;
  int current_index = 0;
  var images = {
    "car_icon.png": "Car",
    "hotel_icon.png": "Hotel",
    "destination_icon.png": "Destination",
    "attraction_icon.png": "Attraction"
  };
  double rating = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
                controller: _controller,
                itemCount: widget.hotelDetails["images"].length,
                onPageChanged: (int index) {
                  setState(() {
                    current_index = index;
                  });
                },
                itemBuilder: (_, index) {
                  return Image.network(
                    widget.hotelDetails["images"][index],
                    //height: 300,
                    fit: BoxFit.cover,
                  );
                }),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(18),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(
                  width: 280,
                ),
                Padding(
                  padding: EdgeInsets.all(18),
                  child: GestureDetector(
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 25,
                    ),
                    onTap: () {
                      toggleFavorite();
                    },
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.2,
            // ),
            SizedBox(
              height: 220,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.hotelDetails["images"].length,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 240),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppLargeText(
                              text: widget.hotelDetails['name'],
                              size: 36,
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: Colors.indigo),
                            AppText(
                                text: widget.hotelDetails['location'],
                                size: 18,
                                color: Colors.indigo),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppLargeText(text: 'Description'),
                        AppText(text: widget.hotelDetails['description']),
                        const SizedBox(
                          height: 20,
                        ),
                        AppLargeText(text: 'Facilities'),
                        BulletedList(
                            bullet: const Padding(
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                Icons.check_circle,
                                size: 24,
                                color: Colors.indigo,
                              ),
                            ),
                            listItems: [
                              widget.hotelDetails['facilities'][0] == true
                                  ? AppText(text: "Car park")
                                  : null,
                              widget.hotelDetails['facilities'][1] == true
                                  ? AppText(text: "Car park")
                                  : null,
                              widget.hotelDetails['facilities'][2] == true
                                  ? AppText(text: "Car park")
                                  : null,
                              // AppText(text: "Car Parking"),
                              // AppText(text: "Car Parking"),
                              // AppText(text: "Car Parking"),
                              // AppText(text: "Car Parking"),
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(text: 'Explore Rooms'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Rooms(
                                                hotelId: widget.hotelDetails.id,
                                              )));
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
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Rooms')
                                  .where('hotelId',
                                      isEqualTo: widget.hotelDetails.id)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.data == null ||
                                    snapshot.data!.docs.isEmpty) {
                                  return Text('No data available');
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (_, index) {
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              padding: const EdgeInsets.all(12),
                                              height: 160,
                                              width: 160,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      snapshot.data!.docs[index]
                                                          ['images'][0]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: GestureDetector(
                                                      child: Icon(
                                                        isFavorite
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
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
                                                      text: snapshot.data!
                                                          .docs[index]['name'],
                                                      color: Colors.white,
                                                    ),
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RoomDetailPage(
                                                            roomDetails:
                                                                snapshot.data!
                                                                        .docs[
                                                                    index],
                                                          )));
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      );
                                    });
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
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
      width: current_index == index ? 10 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: current_index == index
            ? Colors.white
            : Colors.white.withOpacity(0.3),
      ),
    );
  }
}
