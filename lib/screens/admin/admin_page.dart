import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/services/usermanagement.dart';
import 'package:hackathon_project_v1/style/constants.dart';

import 'package:hackathon_project_v1/widgets/user_widgets/bottom_navigator_bar.dart';

//Admin Giriş Yaptıktan Sonra Buraya Pasla

class AdminPage extends StatefulWidget {
  AdminPage({Key key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminPageAppBarWidget(),
      bottomNavigationBar: bottomNavigatorBarWidget(context, colorPrimary),
      floatingActionButton: floatingActionButtonWidget(
          context, Icons.add, "/adminShowProduct", colorPrimary),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(
        child: FlutterLogo(
          size: 200,
        ),
      ),
    );
  }

  //App Bar
  Widget adminPageAppBarWidget() {
    return AppBar(
      backgroundColor: colorPrimary,
      title: Text('Admin Sayfası'),
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
            backgroundColor: kOrange,
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
