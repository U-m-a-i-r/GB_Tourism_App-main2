import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/CSP/csp_service_form.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../../../Widgets/default_button.dart';
import '../../../utils/size_utils.dart';
import '../HSP/hsp_service_form.dart';
import '../Profile/profile_page.dart';
import '../drawer.dart';
import 'all_bookings.dart';

class CSPHomePage extends StatefulWidget {
  const CSPHomePage({Key? key}) : super(key: key);

  @override
  State<CSPHomePage> createState() => _CSPHomePageState();
}

class _CSPHomePageState extends State<CSPHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
            child: Row(
          children: [
            AppLargeText(
              text: 'Welcome to Dashboard',
              size: 20,
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: Icon(Icons.person_rounded, color: Colors.black87),
              ),
            )
          ],
        )),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      drawer: DrawerScreen(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: AppLargeText(text: "Active Services"),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Cars')
                .where('userId',
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
                return Text('No data available');
              }
              return Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      //  var imageURL = await FirebaseStorage.instance.ref().child(baseImageURL +
                      //     snapshot.data!.docs[index]['images'][
                      //       0]).getDownloadURL();
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        padding: const EdgeInsets.all(10),
                        height: getVerticalSize(220),
                        width: getHorizontalSize(160),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data!.docs[index]
                                    ['images'][
                                0]), //AssetImage("lib/assets/WelcomeImage.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PopupMenuButton(
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: AppText(
                                    text: "Update",
                                  ),
                                  onTap: () {
                                    //  Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CSPServiceForm(
                                          isUpdate: true,
                                          carData: snapshot.data!.docs[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: AppText(
                                    text: "Delete",
                                  ),
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('Cars')
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                  },
                                ),
                              ],
                              child: Container(
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: getSize(25),
                                ),
                                alignment: Alignment.topRight,
                              ),
                            ),
                            SizedBox(
                              height: getVerticalSize(45),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: AppText(
                                text: snapshot.data!.docs[index]['name'],
                                color: Colors.white,
                                size: getSize(20),
                              ),
                            ),
                            Container(
                              height: getVerticalSize(50),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.9,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: snapshot.data!.docs[index]
                                              ['status'] ==
                                          "Unbooked"
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                                onPressed: () {
                                  changeStatus(snapshot.data!.docs[index].id,
                                      snapshot.data!.docs[index]['status']);
                                },
                                child: AppLargeText(
                                    text: snapshot.data!.docs[index]['status'],
                                    color: Colors.white,
                                    size: getSize(18)),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            },
          ),
          Positioned(
              bottom: 0,
              child: DefaultButton(
                  buttonText: "Create a Service",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CSPServiceForm(
                                  isUpdate: false,
                                )));
                    //   checkHotel();
                    // showDialogWidget(context);
                  })),
          Positioned(
              bottom: 0,
              child: DefaultButton(
                  buttonText: "Booking Requests",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllCarBookings()));
                    //   checkHotel();
                    // showDialogWidget(context);
                  })),
        ],
      ),
    );
  }

  changeStatus(docId, String status) {
    FirebaseFirestore.instance
        .collection('Cars')
        .doc(docId)
        .update({"status": status == "Unbooked" ? "Booked" : "Unbooked"});
  }
}
