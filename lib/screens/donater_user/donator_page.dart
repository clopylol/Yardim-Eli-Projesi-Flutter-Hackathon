import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/services/usermanagement.dart';
import 'package:hackathon_project_v1/style/constants.dart';

import 'package:hackathon_project_v1/widgets/user_widgets/bottom_navigator_bar.dart';

//Admin Giriş Yaptıktan Sonra Buraya Pasla

class DonatorPage extends StatefulWidget {
  DonatorPage({Key key}) : super(key: key);

  @override
  _DonatorPageState createState() => _DonatorPageState();
}

class _DonatorPageState extends State<DonatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: donatorPageAppBarWidget(),
      bottomNavigationBar: bottomNavigatorBarWidget(context, colorPrimary),
      floatingActionButton: floatingActionButtonWidget(
          context, Icons.add, "/donatorAddProduct", colorPrimary),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(
        child: FlutterLogo(
          size: 200,
        ),
      ),
    );
  }

  //App Bar
  Widget donatorPageAppBarWidget() {
    return AppBar(
      backgroundColor: colorPrimary,
      title: Text(
        'Bağışcı Sayfası',
        style: TextStyle(color: kWhite),
      ),
      //centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/adminShowProduct2');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.power_settings_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            UserManagement().signOut();
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: colorPrimary,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/37087597?v=4'),
              //Login Eklenince burayı dinamik yaparız.
            ),
          ),
        ),
      ],
    );
  }
}
