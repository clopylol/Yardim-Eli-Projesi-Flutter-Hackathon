import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/helpers/media_query_helper.dart';
import 'package:hackathon_project_v1/services/usermanagement.dart';

Widget homeAppBarWidget(context) {
  return Padding(
    padding: EdgeInsets.only(top: 25, left: 10, right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 28,
          ),
          color: Colors.white,
          onPressed: () {},
        ),
        Container(
          width: displayWidth(context) * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 28,
                ),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 28,
                ),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                iconSize: 35,
                icon: Icon(
                  Icons.power_settings_new_rounded,
                  size: 28,
                ),
                color: Colors.white,
                onPressed: () {
                  UserManagement().signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
              ),
            ],
          ),
        )
      ],
    ),
  );
}
