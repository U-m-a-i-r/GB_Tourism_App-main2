import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/HSP/room_images_picker.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/default_button.dart';
import '../../../utils/file_upload_helper.dart';
import '../../../utils/progress_dialog_utils.dart';
import '../../../utils/size_utils.dart';
import 'hsp_service_form.dart';

class RoomRegForm extends StatefulWidget {
  final hotelId;
  const RoomRegForm({Key? key, required this.hotelId}) : super(key: key);

  @override
  State<RoomRegForm> createState() => _RoomRegFormState();
}

class _RoomRegFormState extends State<RoomRegForm> {
  TextEditingController roomName = TextEditingController();
  TextEditingController roomNo = TextEditingController();
  TextEditingController roomprice = TextEditingController();
  TextEditingController description = TextEditingController();
  RxList<File> listFiles = <File>[].obs;
  List<String> filesURL = [];
  List dropDownListData = [
    {"title": "Hunza", "value": "1"},
    {"title": "Skardu", "value": "2"},
    {"title": "Shigar", "value": "3"},
    {"title": "Tolti", "value": "4"},
  ];

  String defaultValue = "";
  String secondDropDown = "";
  Map<String, dynamic> facilities = {};

  final allChecked = CheckBoxModel(title: "All Checked", id: 5);
  final checkBoxList = [
    CheckBoxModel(title: "Car park", id: 0),
    CheckBoxModel(title: "Free Wi-Fi in all rooms!", id: 1),
    CheckBoxModel(title: "Luggage storage", id: 2),
  ];

  String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  Future<void> uploadImages(List<File> files) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseStorage storage = FirebaseStorage.instance;

    for (int i = 0; i < files.length; i++) {
      String uniqueId = generateUniqueId();
      File file = files[i];
      String filePath = 'images/$uid/image$uniqueId.jpg';

      await storage.ref(filePath).putFile(file);
      var url = await storage.ref(filePath).getDownloadURL();
      filesURL.add(url);
    }
  }

  addRoom() async {
    if (roomName.text.isEmpty ||
        description.text.isEmpty ||
        roomNo.text.isEmpty ||
        roomprice.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: "Please fill all the fields",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    } else if (listFiles.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: "Please upload atleast 1 image",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    } else {
      ProgressDialogUtils.showProgressDialog();
      uploadImages(listFiles.value).then((value) async {
        // for (File file in listFiles) {
        //   Uint8List imageBytes = await file.readAsBytes();
        //   imageBytesList.add(imageBytes);
        // }
        for (var element in checkBoxList) {
          facilities[element.id.toString()] = element.value;
        }
        await FirebaseFirestore.instance.collection('Rooms').doc().set({
          'name': roomName.text,
          'number': roomNo.text,
          'price': roomprice.text,
          'hotelId': widget.hotelId,
          'description': description.text,
          //  'place': defaultValue,
          'images': filesURL,
          'facilities': facilities,
          "isFavorite": false,
          'status': 'Unbooked'
        }).then((value) {
          ProgressDialogUtils.hideProgressDialog();
          Get.showSnackbar(const GetSnackBar(
            message: "Room added successfully",
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          ));
          Navigator.pop(context);
        });
      });
    }
    //  Navigator.pushReplacement(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => RoomRegForm(
    //                           hotelId: "",
    //                         )));
  }

  @override
  void dispose() {
    roomName.dispose();
    roomNo.dispose();
    roomprice.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.only(left: 40),
          child: AppLargeText(
            text: 'Room Registration Form',
            size: 20,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: AppLargeText(
                    text: "Room Name",
                    size: 20,
                  )),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: roomName,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Enter Room Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: AppLargeText(
                    text: "Room Number",
                    size: 20,
                  )),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: roomNo,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Enter Room Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: AppLargeText(
                    text: "Description",
                    size: 20,
                  )),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: description,
                minLines: 5,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Enter Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Align(
              //     alignment: Alignment.topLeft,
              //     child: AppLargeText(
              //       text: "Place",
              //       size: 20,
              //     )),
              // SizedBox(
              //   height: 8,
              // ),
              // InputDecorator(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //     contentPadding: const EdgeInsets.all(20),
              //   ),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<String>(
              //         isDense: true,
              //         value: defaultValue,
              //         isExpanded: true,
              //         menuMaxHeight: 350,
              //         items: [
              //           const DropdownMenuItem(
              //               child: Text(
              //                 "Select Place",
              //               ),
              //               value: ""),
              //           ...dropDownListData
              //               .map<DropdownMenuItem<String>>((data) {
              //             return DropdownMenuItem(
              //                 child: Text(data['title']), value: data['value']);
              //           }).toList(),
              //         ],
              //         onChanged: (value) {
              //           print("selected Value $value");
              //           setState(() {
              //             defaultValue = value!;
              //           });
              //         }),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Align(
              //     alignment: Alignment.topLeft,
              //     child: AppLargeText(
              //       text: "Hotel Location",
              //       size: 20,
              //     )),
              // SizedBox(
              //   height: 8,
              // ),
              // TextFormField(
              //   controller: location,
              //   decoration: InputDecoration(
              //       filled: true,
              //       hintText: "Enter Location",
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10))),
              // ),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: AppLargeText(
                    text: "Room Price/Day",
                    size: 20,
                  )),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: roomprice,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Enter Room Price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: AppLargeText(
                    text: "Upload Pictures",
                    size: 20,
                  )),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: getPadding(all: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          FileManager().showModelSheetForImage(
                              allowedExtensions: ['png', 'jpg', 'jpeg'],
                              getImages: (images) {
                                for (var element in images) {
                                  listFiles.add(File(element!));
                                }
                              });
                          // _showPicker2(context);
                        },
                        child: SizedBox(
                          height: getVerticalSize(160),
                          width: getHorizontalSize(120),
                          child: Card(
                            elevation: 5,
                            child: Image.asset(
                              'Assets/upload_icon.png',
                              width: 80,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => listFiles.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 160,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: listFiles.value.length,
                            itemBuilder: (ctx, index) {
                              return Column(
                                children: <Widget>[
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        final snackBar = SnackBar(
                                          content: const Text(
                                              'Do you want to remove ?'),
                                          action: SnackBarAction(
                                            label: 'Delete',
                                            onPressed: () {
                                              listFiles.removeAt(index);
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(ctx)
                                            .showSnackBar(snackBar);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: listFiles.isNotEmpty
                                            ? ClipRRect(
                                                child: Image.file(
                                                  listFiles.value[index],
                                                  width: 120,
                                                  height: 160,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              )
                                            : Container(),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                      ),
                    )
                  : Container()),
              Align(
                  alignment: Alignment.topLeft,
                  child: AppLargeText(
                    text: "Room Services",
                    size: 20,
                  )),
              SizedBox(
                height: 8,
              ),
              ListTile(
                onTap: () => onAllClicked(allChecked),
                leading: Checkbox(
                  value: allChecked.value,
                  onChanged: (value) => onAllClicked(allChecked),
                ),
                title: AppLargeText(
                  text: allChecked.title,
                  size: 20,
                ),
              ),
              Divider(),
              ...checkBoxList
                  .map(
                    (item) => ListTile(
                      onTap: () => onItemClicked(item),
                      leading: Checkbox(
                        value: item.value,
                        onChanged: (value) => onItemClicked(item),
                      ),
                      title: AppLargeText(text: item.title, size: 18),
                    ),
                  )
                  .toList(),
              DefaultButton(
                buttonText: "ADD ROOM",
                press: () {
                  addRoom();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const HotelImagesPicker()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  onAllClicked(CheckBoxModel ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;
      checkBoxList.forEach((element) {
        element.value = newValue;
      });
    });
  }

  onItemClicked(CheckBoxModel ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;
      if (!newValue) {
        allChecked.value = false;
      } else {
        final allListChecked = checkBoxList.every((element) => element.value);
        allChecked.value = allListChecked;
      }
    });
  }
}
