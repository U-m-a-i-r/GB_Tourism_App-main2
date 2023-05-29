import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FavItemsPage extends StatelessWidget {
  const FavItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: const Center(
        child: Text("No Favorite items yet!"),
      ),
    );
  }
}
