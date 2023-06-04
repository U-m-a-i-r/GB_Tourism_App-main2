import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../../Widgets/app_large_text.dart';

class AllCarBookings extends StatefulWidget {
  const AllCarBookings({super.key});

  @override
  State<AllCarBookings> createState() => _AllCarBookingsState();
}

class _AllCarBookingsState extends State<AllCarBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
            margin: EdgeInsets.only(left: 40),
            child: AppLargeText(
              text: 'Booking Requests',
              size: 20,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('CarBooking')
                .where('owernerId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                return Text('No booking requests');
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 3.0, // Border width
                          ),
                          borderRadius:
                              BorderRadius.circular(8.0), // Border radius
                        ),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.docs[index]['name'],
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snapshot.data!.docs[index]['contactNo'],
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                'Destination: ' +
                                    snapshot.data!.docs[index]['destination'],
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                'Date: ' +
                                    snapshot.data!.docs[index]['reservedDate']
                                        .toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  // radius: 30,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.request_page,
                                    size: 50,
                                    color: Colors.blue,
                                  )),
                            ],
                          ),
                          trailing: Column(
                            children: [
                              Container(
                                height: 25,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('Cars')
                                            .doc(snapshot.data!.docs[index]
                                                ['carId'])
                                            .update({"status": "Booked"});
                                        FirebaseFirestore.instance
                                            .collection('CarBooking')
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                      },
                                      icon: Icon(
                                        Icons.check_circle,
                                        color: Colors.indigo,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('CarBooking')
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.indigo,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
            }));
  }
}
