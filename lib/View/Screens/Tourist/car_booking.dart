import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/CSP/cars.dart';
import 'package:gb_tour/utils/date_time_utils.dart';
import 'package:get/get.dart';

import '../../../Widgets/default_button.dart';
import '../../../utils/progress_dialog_utils.dart';

class CarBooking extends StatefulWidget {
  final dynamic carDetails;

  const CarBooking({Key? key, required this.carDetails}) : super(key: key);

  @override
  State<CarBooking> createState() => _CarBookingState();
}

class _CarBookingState extends State<CarBooking> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController personsController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bookCar() async {
    if (nameController.text.isEmpty ||
        contactController.text.isEmpty ||
        destinationController.text.isEmpty ||
        personsController.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: "Please fill all the fields",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    } else if (widget.carDetails['userId'] ==
        FirebaseAuth.instance.currentUser!.uid) {
      Get.showSnackbar(const GetSnackBar(
        message: "This is your own car!",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    } else {
      ProgressDialogUtils.showProgressDialog();
      await FirebaseFirestore.instance.collection('CarBooking').doc().set({
        'name': nameController.text,
        'contactNo': contactController.text,
        'destination': destinationController.text,
        'persons': personsController.text,
        'reservedDate': selectedDate.format(),
        "userId": FirebaseAuth.instance.currentUser!.uid,
        'carId': widget.carDetails.id,
        'owernerId': widget.carDetails['userId']
      }).then((value) {
        ProgressDialogUtils.hideProgressDialog();
        Get.showSnackbar(const GetSnackBar(
          message: "Booking request sent successfully",
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Cars()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
          ),
          title: Text(
            'Book Your Car',
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.indigo),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextFormField(
                  controller: contactController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.indigo),
                    ),
                    labelText: 'Contact',
                    hintText: 'Enter Your Contact Number',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextFormField(
                  controller: destinationController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.indigo),
                    ),
                    labelText: 'Destination',
                    hintText: 'Enter Your Destination',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextField(
                  controller: personsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.indigo),
                    ),
                    labelText: 'persons',
                    hintText: 'Enter no of persons ',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo, // Background color
                      ),
                      onPressed: () => _selectDate(context),
                      child: const Text('Select date for Reservation'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DefaultButton(
                buttonText: "Book Now",
                press: () {
                  bookCar();
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => Cars()));
                },
              )
            ],
          ),
        ));
  }
}
