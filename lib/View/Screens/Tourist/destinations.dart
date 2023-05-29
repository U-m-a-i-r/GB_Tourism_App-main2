import 'package:flutter/material.dart';
import 'package:gb_tour/View/Screens/Profile/profile_page.dart';
import 'package:gb_tour/View/Screens/Tourist/places.dart';

import '../../../Widgets/app_large_text.dart';
import '../../../Widgets/app_text.dart';
import '../drawer.dart';

class PopularDestinations extends StatefulWidget {
  const PopularDestinations({Key? key}) : super(key: key);

  @override
  State<PopularDestinations> createState() => _PopularDestinationsState();
}

class _PopularDestinationsState extends State<PopularDestinations> {
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
              margin: const EdgeInsets.only(left: 70),
              child: AppLargeText(
                text: 'Gilgit Baltistan',
                size: 20,
              ),
            ),
            const Spacer(),
            GestureDetector(
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.black87,
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
              },
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      drawer: const DrawerScreen(),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 8,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Places()));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.all(12),
                height: 220,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage("lib/assets/WelcomeImage.jpeg"),
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

                        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 25,
                        ),
                        onTap: (){
                          toggleFavorite();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: AppText(
                            text: 'City Name',
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
