import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/HSP/room_reg_form.dart';
import 'package:gb_tour/View/Screens/Profile/profile_page.dart';
import 'package:gb_tour/View/Screens/HSP/hsp_service_form.dart';
import 'package:gb_tour/Widgets/default_button.dart';
import 'package:gb_tour/utils/size_utils.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../../../utils/constantsl.dart';
import '../../../utils/progress_dialog_utils.dart';
import '../drawer.dart';

class HSPHomePage extends StatefulWidget {
  const HSPHomePage({Key? key}) : super(key: key);

  @override
  State<HSPHomePage> createState() => _HSPHomePageState();
}

class _HSPHomePageState extends State<HSPHomePage> {
  Color _buttonColor = Colors.red;
  String _buttonText = 'Booked';

  void _changeButtonState() {
    setState(() {
      if (_buttonColor == Colors.grey) {
        _buttonColor = Colors.red;
        _buttonText = 'Booked';
      } else {
        _buttonColor = Colors.grey;
        _buttonText = 'Unbooked';
      }
    });
  }

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
                size: getSize(20),
              ),
              Spacer(),
              CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      child: Icon(Icons.person_rounded, color: Colors.black87)))
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
                  .collection('Rooms')
                  .where('hotelId',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                                  ),
                                  PopupMenuItem(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: AppText(
                                      text: "Delete",
                                    ),
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection('Rooms')
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                      text: snapshot.data!.docs[index]
                                          ['status'],
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
                      checkHotel();
                      // showDialogWidget(context);
                    })),
          ],
        )
        //  ListView.builder(
        //   itemCount: snapshot.data!.docs.length,
        //   itemBuilder: (BuildContext context, int index) {

        //     return ListTile(
        //       title: Text(snapshot.data!.docs[index]['name']),
        //       //  subtitle: Text(snapshot.data!.docs[index].data()['description']),
        //     );
        //   },
        // );

        );
  }

  changeStatus(docId, String status) {
    FirebaseFirestore.instance
        .collection('Rooms')
        .doc(docId)
        .update({"status": status == "Unbooked" ? "Booked" : "Unbooked"});
  }

  checkHotel() async {
    ProgressDialogUtils.showProgressDialog();
    var userHotel = await FirebaseFirestore.instance
        .collection('Hotels')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    ProgressDialogUtils.hideProgressDialog();
    if (userHotel.exists) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RoomRegForm(
                    hotelId: userHotel.id,
                  )));
    } else {
      // ignore: use_build_context_synchronously
      showDialogWidget(context);
    }
  }

  showDialogWidget(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: AppLargeText(text: "Alert"),
      content: AppText(
        text: "Please register your hotel first!",
      ),
      actions: [
        DefaultButton(
          buttonText: "Register Hotel",
          press: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HSPServiceForm()));
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
