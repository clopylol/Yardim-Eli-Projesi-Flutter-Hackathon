import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon_project_v1/style/constants.dart';

class SocialIcon extends StatelessWidget {
  final String iconSource;
  final Function press;
  const SocialIcon({
    Key key,
    this.iconSource,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: kPrimaryColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSource,
          height: 20,
          width: 20,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
