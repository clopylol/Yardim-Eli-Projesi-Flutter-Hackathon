import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon_project_v1/screens/login/login_screen.dart';
import 'package:hackathon_project_v1/screens/signup/components/background.dart';
import 'package:hackathon_project_v1/screens/signup/components/or_divider.dart';
import 'package:hackathon_project_v1/screens/signup/components/social_icon.dart';
import 'package:hackathon_project_v1/services/usermanagement.dart';
import 'package:hackathon_project_v1/style/constants.dart';
import 'package:hackathon_project_v1/widgets/componets/already_have_an_account_check.dart';
import 'package:hackathon_project_v1/widgets/componets/rounded_button.dart';
import 'package:hackathon_project_v1/widgets/componets/rounded_input_field.dart';
import 'package:hackathon_project_v1/widgets/componets/rounded_password_field.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserManagement service = UserManagement();
  String userName, password, userRole;

  bool _selectedDonater = true;
  bool _selectedUser = false;

  String _donaterText = "Bağış Talebi";
  String _userText = "Yardım Talebi";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "KAYIT OL",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset("assets/icons/signup.svg",
                height: size.height * 0.30),
            SizedBox(height: size.height * 0.025),
            RoundedInputField(
              hintText: "E-posta Adresiniz",
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              }, //dk 13.58
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                filterChipRoleSelectDonator(),
                SizedBox(width: size.width * 0.03),
                filterChipRoleSelectUser(),
              ],
            ),
            RoundedButton(
              text: "KAYIT OL",
              press: () {
                //var result =
                service
                    .userSignUp(
                        userName: userName,
                        userPassword: password,
                        userRole: userRole)
                    .whenComplete(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Kayıt Başarılı !"),
                        content: Text(
                            "Kayıt işlemi başarıyla tamamlandı ! Giriş sayfasından giriş yapabilirsin."),
                        actions: [
                          TextButton(
                            child: Text(
                              "İptal",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: kBlack),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              "Giriş Sayfası",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: kOrange),
                            ),
                            onPressed: () {
                              userName = "";
                              password = "";
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (route) => false);
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
              },
            ),
            SizedBox(height: size.height * 0.02),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                debugPrint("Giriş Ekranına Geçildi");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  iconSource: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSource: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSource: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget filterChipRoleSelectDonator() {
    return Theme(
      data: ThemeData.dark(),
      child: FilterChip(
          selected: _selectedDonater,
          selectedColor: kPrimaryColor,
          backgroundColor: kPrimaryLightColor,
          label: Text(
            _donaterText,
          ),
          labelStyle:
              TextStyle(color: _selectedDonater == true ? kWhite : kBlack),
          onSelected: (bool selected) {
            setState(() {
              userRole = "donator";
              print(userRole);
              _selectedDonater = true;
              _selectedUser = false;
            });
          }),
    );
  }

  Widget filterChipRoleSelectUser() {
    return Theme(
      data: ThemeData.dark(),
      child: FilterChip(
          selected: _selectedUser,
          selectedColor: kPrimaryColor,
          backgroundColor: kPrimaryLightColor,
          label: Text(_userText),
          labelStyle: TextStyle(color: _selectedUser == true ? kWhite : kBlack),
          onSelected: (bool selected) {
            setState(() {
              userRole = "user";
              print(userRole);
              _selectedUser = true;
              _selectedDonater = false;
            });
          }),
    );
  }
}
