import 'package:bulleted_list/bulleted_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../../../Widgets/default_button.dart';
import '../onboarding_hotel_images.dart';
import 'car_booking.dart';

class CSPDetailPage extends StatefulWidget {
  final dynamic carDetails;
  const CSPDetailPage({Key? key, required this.carDetails}) : super(key: key);

  @override
  State<CSPDetailPage> createState() => _CSPDetailPageState();
}

class _CSPDetailPageState extends State<CSPDetailPage> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  List<Widget> facilities = [];
  getFacilities() {
    print(widget.carDetails['facilities']);
    if (widget.carDetails['facilities']['0'] == true) {
      facilities.add(AppText(text: "Car park"));
    }
    if (widget.carDetails['facilities']['1'] == true) {
      facilities.add(AppText(text: "Free Wi-Fi in all rooms!"));
    }
    if (widget.carDetails['facilities']['2'] == true) {
      AppText(text: "Luggage storage");
    }
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
    getFacilities();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
                controller: _controller,
                itemCount: widget.carDetails["images"].length,
                onPageChanged: (int index) {
                  setState(() {
                    current_index = index;
                  });
                },
                itemBuilder: (_, index) {
                  return Image.network(
                    widget.carDetails["images"][index],
                    //height: 300,
                    fit: BoxFit.cover,
                  );
                }),
            Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      widget.carDetails['isFavorite']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                      size: 25,
                    ),
                    onTap: () {
                      toggleFavoriteCar(widget.carDetails.id,
                          widget.carDetails['isFavorite']);
                    },
                  )
                ],
              ),
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
                  widget.carDetails["images"].length,
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
                              text: widget.carDetails['name'],
                              size: 36,
                            ),
                            AppLargeText(
                                text: "${widget.carDetails['price']}/Day",
                                size: 22),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: Colors.indigo),
                            AppText(
                                text: widget.carDetails['location'],
                                size: 18,
                                color: Colors.indigo),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppLargeText(text: 'Car Model'),
                        AppText(text: widget.carDetails['model']),
                        const SizedBox(
                          height: 20,
                        ),
                        AppLargeText(text: 'Description'),
                        AppText(text: widget.carDetails['description']),
                        const SizedBox(
                          height: 20,
                        ),
                        AppLargeText(text: 'Services'),
                        BulletedList(
                            bullet: const Padding(
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                Icons.check_circle,
                                size: 24,
                                color: Colors.indigo,
                              ),
                            ),
                            listItems: facilities
                            // [
                            //   AppText(text: "Service 1"),
                            //   AppText(text: "Service 2"),
                            //   AppText(text: "Service 3"),
                            //   AppText(text: "Service 4"),
                            //   AppText(text: "Service 5"),
                            // ]
                            ),
                        SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 25,
                bottom: 0,
                child: DefaultButton(
                  buttonText: "Book Now",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => CarBooking(
                                  carDetails: widget.carDetails,
                                ))));
                    // bookCar();
                  },
                ))
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
