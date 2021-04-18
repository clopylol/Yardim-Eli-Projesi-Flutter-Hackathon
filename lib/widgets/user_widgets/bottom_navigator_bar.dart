import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/helpers/media_query_helper.dart';

Widget bottomNavigatorBarWidget(context, Color color) {
  return BottomAppBar(
    shape: CircularNotchedRectangle(),
    color: color,
    child: Container(
      height: displayHeight(context) * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.home),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.admin_panel_settings),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/adminPage');
            },
          ),
        ],
      ),
    ),
  );
}

Widget floatingActionButtonWidget(
    BuildContext context, IconData icon, String route, Color color) {
  return FloatingActionButton(
    backgroundColor: color,
    splashColor: Colors.orange[300],
    onPressed: () => Navigator.pushNamed(context, route),
    child: Icon(
      icon,
      size: 25,
    ),
  );
}
