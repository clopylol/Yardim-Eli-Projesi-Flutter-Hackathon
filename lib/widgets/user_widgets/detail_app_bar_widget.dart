import 'package:flutter/material.dart';

Widget appBarWidget() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    // leading: IconButton(
    //   icon: IconButton(
    //     icon: Icon(Icons.arrow_back),
    //     color: Colors.white,
    //     onPressed: () {},
    //   ),
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    // ),
    title: Text(
      'Ürün Detayı',
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
    ],
  );
}
