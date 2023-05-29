import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/Tourist/places.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../CSP/cars.dart';
import 'csp_detail_page.dart';
import 'hotel_detail_page.dart';
import '../HSP/hotels.dart';
import '../onboarding_hotel_images.dart';

class PlacesDetailPage extends StatefulWidget {
  const PlacesDetailPage({Key? key}) : super(key: key);

  @override
  State<PlacesDetailPage> createState() => _PlacesDetailPageState();
}

class _PlacesDetailPageState extends State<PlacesDetailPage> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  int current_index = 0;
  late PageController _controller;
  double rating = 0;
  var images = {
    "car_icon.png": "Car",
    "hotel_icon.png": "Hotel",
    "destination_icon.png": "Destination",
    "attraction_icon.png": "Attraction"
  };

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
                controller: _controller,
                itemCount: hotelImages.length,
                onPageChanged: (int index) {
                  setState(() {
                    current_index = index;
                  });
                },
                itemBuilder: (_, index) {
                  return Image.asset(
                    hotelImages[index].hotelImage,
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
                  hotelImages.length,
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
                              text: 'Place Name',
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
                                text: 'Location',
                                size: 18,
                                color: Colors.indigo),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppLargeText(text: 'Description'),
                        AppText(
                            text:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(text: 'Nearby Hotels'),
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
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (_, Index) {
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
                                            image: AssetImage(
                                                "lib/assets/WelcomeImage.jpeg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
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
                                                text: 'Hotel Name',
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
                                                      hotelDetails: "",
                                                    )));
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(text: 'Nearby Cars'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Cars()));
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
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (_, Index) {
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
                                            image: AssetImage(
                                                "lib/assets/WelcomeImage.jpeg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
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
                                                text: 'Car Name',
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
                                                    CSPDetailPage()));
                                      },
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(text: 'Nearby Attractions'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Places()));
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
                          height: 200,
                          width: double.maxFinite,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (_, Index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        padding: const EdgeInsets.all(12),
                                        height: 180,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "lib/assets/WelcomeImage.jpeg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                text: 'Place Name',
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
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlacesDetailPage()));
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
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
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: current_index == index
            ? Colors.white
            : Colors.white.withOpacity(0.3),
      ),
    );
  }
}
