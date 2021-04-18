import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/style/constants.dart';
import 'package:hackathon_project_v1/widgets/componets/text_file_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        //Şifre şeklinde gözüksün ***
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Şifreniz",
          icon: Icon(Icons.lock, color: kPrimaryColor),
          //Sağa Dayalı Icon
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
