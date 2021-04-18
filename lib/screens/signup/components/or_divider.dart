import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/style/constants.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.018),
      width: size.width * 0.6,
      child: Row(
        children: [
          buildDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "VEYA",
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Colors.grey,
        height: 1.5,
      ),
    );
  }
}
