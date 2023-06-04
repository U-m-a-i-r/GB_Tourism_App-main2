import 'dart:io';

import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../../../Widgets/default_button.dart';

import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'hotel_booking.dart';

class RoomDetailPage extends StatefulWidget {
  final dynamic roomDetails;
  const RoomDetailPage({Key? key, required this.roomDetails}) : super(key: key);

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
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
  List<Widget> facilities = [];
  getFacilities() {
    print(widget.roomDetails['facilities']);
    if (widget.roomDetails['facilities']['0'] == true) {
      facilities.add(AppText(text: "Car park"));
    }
    if (widget.roomDetails['facilities']['1'] == true) {
      facilities.add(AppText(text: "Free Wi-Fi in all rooms!"));
    }
    if (widget.roomDetails['facilities']['2'] == true) {
      AppText(text: "Luggage storage");
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: 370,
              child: PageView.builder(
                  controller: _controller,
                  itemCount: widget.roomDetails["images"].length,
                  onPageChanged: (int index) {
                    setState(() {
                      current_index = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    return Image.network(
                      widget.roomDetails["images"][index],
                      //height: 300,
                      fit: BoxFit.cover,
                    );
                  }),
            ),
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
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 25,
                    ),
                    onTap: () {
                      toggleFavorite();
                    },
                  ),
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
                  widget.roomDetails["images"].length,
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
                              text: widget.roomDetails['name'],
                              size: 36,
                            ),
                            AppLargeText(
                                text: "${widget.roomDetails['price']}/Day",
                                size: 22),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppLargeText(text: 'Description'),
                        AppText(text: widget.roomDetails['description']),
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
                            listItems: facilities),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                            builder: (context) => HotelBooking(
                                  roomDetails: widget.roomDetails,
                                )));
                    // openWhatsApp();
                  },
                ))
          ],
        ),
      ),
    );
  }

  openWhatsApp() async {
    var whatsapp = "+923020519264";
    var whatsappurlAndroid = "whatsapp://send?phone=$whatsapp&text=Hello";
    var whatsappurlIos = "https://wa.me/$whatsapp?text=${Uri.parse('Hello')}";
    if (Platform.isIOS) {
      if (await url_launcher.canLaunch(whatsappurlIos)) {
        await url_launcher.launch(whatsappurlIos);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Unable to open Whatsapp!')));
      }
    } else {
      if (await url_launcher.canLaunch(whatsappurlAndroid)) {
        await url_launcher.launch(whatsappurlAndroid);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Unable to open Whatsapp!')));
      }
    }
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
