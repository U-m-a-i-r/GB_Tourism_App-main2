import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../CSP/cars.dart';
import '../HSP/hotels.dart';
import 'csp_detail_page.dart';
import 'hotel_detail_page.dart';

class FavItemsPage extends StatelessWidget {
  const FavItemsPage({Key? key}) : super(key: key);

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 24, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppLargeText(text: 'Hotels'),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Hotels()));
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
                      .where('isFavorite', isEqualTo: true)
                      //    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
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
                                            toggleFavoriteHotels(
                                                snapshot.data!.docs[index].id,
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
                                      /*Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      allowHalfRating: true,
                                      unratedColor: Colors.grey,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1),
                                      updateOnDrag: true,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (ratingvalue) {
                                        setState(() {
                                          Rating = ratingvalue;
                                        });
                                      },
                                    ),
                                    Text(
                                      '$Rating',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.person_rounded,
                                        color: Colors.white,
                                      ),
                                      radius: 15,
                                      backgroundColor: Colors.indigo,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Container(
                                      child: AppText(
                                        text: 'Owner Name',
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.bottomLeft,
                                    ),
                                  ],
                                ),*/
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HotelDetailPage(
                                                hotelDetails:
                                                    snapshot.data!.docs[index],
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
                    .where('isFavorite', isEqualTo: true)
                    //    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                              snapshot.data!.docs[index].id,
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
                                    /*Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      allowHalfRating: true,
                                      unratedColor: Colors.grey,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1),
                                      updateOnDrag: true,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (ratingvalue) {
                                        setState(() {
                                          Rating = ratingvalue;
                                        });
                                      },
                                    ),
                                    Text(
                                      '$Rating',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.person_rounded,
                                        color: Colors.white,
                                      ),
                                      radius: 15,
                                      backgroundColor: Colors.indigo,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Container(
                                      child: AppText(
                                        text: 'Owner Name',
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.bottomLeft,
                                    ),
                                  ],
                                ),*/
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CSPDetailPage(
                                              carDetails:
                                                  snapshot.data!.docs[index],
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
    );
  }
}
