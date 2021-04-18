import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/screens/login/components/background.dart';
import 'package:hackathon_project_v1/screens/signup/signup_screen.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon_project_v1/services/firebase_service.dart';
import 'package:hackathon_project_v1/services/usermanagement.dart';
import 'package:hackathon_project_v1/widgets/componets/already_have_an_account_check.dart';
import 'package:hackathon_project_v1/widgets/componets/rounded_button.dart';
import 'package:hackathon_project_v1/widgets/componets/rounded_input_field.dart';
import 'package:hackathon_project_v1/widgets/componets/rounded_password_field.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String username, password;
  FirebaseServices services = FirebaseServices();
  GlobalKey<ScaffoldState> scafold = GlobalKey();

  UserManagement service = UserManagement();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "GİRİŞ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.30,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "E-posta Adresiniz",
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              RoundedButton(
                text: "GİRİŞ",
                press: () async {
                  var result = await service.userSignIn(
                      context: context,
                      userName: username,
                      userPassword: password);

                  // FirebaseFirestore.instance
                  //     .collection("profile")
                  //     .doc(username)
                  //     .get()
                  //     .then((value) {
                  //   print(value.data());
                  //   var role = value.data()['role'];
                  // });
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
