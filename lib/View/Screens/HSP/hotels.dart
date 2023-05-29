import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/Tourist/hotel_detail_page.dart';
import 'package:gb_tour/Widgets/app_text.dart';

import '../../../Widgets/app_large_text.dart';
import '../Profile/profile_page.dart';
import '../drawer.dart';

class Hotels extends StatefulWidget {
  const Hotels({Key? key}) : super(key: key);

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 105),
              child: AppLargeText(
                text: 'Hotels',
                size: 20,
              ),
            ),
            Spacer(),
            GestureDetector(
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      drawer: DrawerScreen(),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Hotels')
              //  .where('hotelId',
              //    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                              builder: (context) => HotelDetailPage(
                                    hotelDetails: snapshot.data!.docs[index],
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
}
