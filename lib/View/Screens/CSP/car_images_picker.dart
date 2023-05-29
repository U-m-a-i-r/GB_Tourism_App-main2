import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/CSP/csp_home_page.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../../../Widgets/default_button.dart';

class CarImagesPicker extends StatefulWidget {
  const CarImagesPicker({Key? key}) : super(key: key);

  @override
  State<CarImagesPicker> createState() => _CarImagesPickerState();
}

class _CarImagesPickerState extends State<CarImagesPicker> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          margin: const EdgeInsets.only(left: 50),
          child: AppLargeText(
            text: 'Select Car Images',
            size: 20,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: Column(
          children: [

            Center(
              child: OutlinedButton(
                  onPressed: () {
                    imageSelect();
                  },
                  child: AppText(
                    text: "Select Images",
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: _imageFileList!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SingleChildScrollView(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(
                                File(_imageFileList![index].path),
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 4,
                                top: 4,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red[500],
                                    onPressed: () {
                                      _imageFileList!.removeAt(index);
                                      setState(() {});
                                    },
                                  ),
                                  color: const Color.fromRGBO(255, 255, 244, 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            DefaultButton(buttonText: "Post", press: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CSPHomePage()));
            },),
          ],
        ),
      ),
    );
  }
  void imageSelect() async {
    final XFile? selectedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage!.path.isNotEmpty) {
      _imageFileList!.add(selectedImage);
    }
  }
}
